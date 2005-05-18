Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVERHkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVERHkt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVERHkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:40:49 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:3807 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262116AbVERHki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:40:38 -0400
Date: Wed, 18 May 2005 09:14:38 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: =?UTF-8?B?UG96c8OhciBCYWzDoXpz?= <pozsy@uhulinux.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops on CF removal and "convert device drivers to driver-model"
In-Reply-To: <20050517145137.6b91f242.zaitcev@redhat.com>
Message-ID: <Pine.GSO.4.62.0505180903580.7915@mion.elka.pw.edu.pl>
References: <20050514135019.0b3252f1.zaitcev@redhat.com>
 <20050517211704.GB7452@ojjektum.uhulinux.hu> <20050517145137.6b91f242.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1116400097=:7915"
Content-ID: <Pine.GSO.4.62.0505180909150.7915@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-851401618-1116400097=:7915
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.GSO.4.62.0505180909151.7915@mion.elka.pw.edu.pl>


On Tue, 17 May 2005, Pete Zaitcev wrote:

> On Tue, 17 May 2005 23:17:04 +0200, Pozs=E1r Bal=E1zs <pozsy@uhulinux.hu>=
 wrote:
>
>> On Sat, May 14, 2005 at 01:50:19PM -0700, Pete Zaitcev wrote:
>>> @@ -1138,7 +1133,8 @@ static int idescsi_attach(ide_drive_t *d
>>>  =09idescsi->host =3D host;
>>>  =09idescsi->disk =3D g;
>>>  =09g->private_data =3D &idescsi->driver;
>>> -=09err =3D ide_register_subdriver(drive, &idescsi_driver);
>>> +=09ide_register_subdriver(drive, &idescsi_driver);
>>> +=09err =3D 0;
>>>  =09if (!err) {
>>>  =09=09idescsi_setup (drive, idescsi);
>>>  =09=09g->fops =3D &idescsi_ops;
>>
>> !err cannot be true here, so this seems buggy.

check for !err is always true here and can be removed

> Indeed.
>
> Unfortunately, Andrew's scripts notified me that he added the patch to
> his tree, so I'd need to wait for a turnaround before a fix-over-fix.

Pete, the version of the patch you've posted is not the final one
- it misses ->probe() return value fixes.

I'll push the fixed one to Linus.

Thanks,
Bartlomiej
---559023410-851401618-1116400097=:7915--
