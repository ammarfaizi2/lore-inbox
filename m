Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbUCTLbS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 06:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUCTLbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 06:31:17 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:20404 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263387AbUCTLbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 06:31:15 -0500
Message-ID: <405C2AC0.70605@stesmi.com>
Date: Sat, 20 Mar 2004 12:28:00 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Peter Williams <peterw@aurema.com>, Micha Feigin <michf@post.tau.ac.il>,
       John Reiser <jreiser@BitWagon.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com> <4053624D.6080806@BitWagon.com> <20040313193852.GC12292@devserv.devel.redhat.com> <40564A22.5000504@aurema.com> <20040316063331.GB23988@devserv.devel.redhat.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com>
In-Reply-To: <20040320102241.GK2803@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>there is one. Nothing uses it
>>>(sysconf() provides this info)
>>
>>Seems to me that it would be fairly trivial to modify those programs 
>>(that should use this mechanism but don't) to use it?  So why should 
>>they be allowed to dictate kernel behaviour?
> 
> 
> quality of implementation; for example shell scripts that want to do
> echo 500 > /proc/sys/foo/bar/something_in_HZ
> ...
> or /etc/sysctl.conf or ...
> 

Then write a simple program already. How hard is it to write a program
that does a sysconf() and returns (as ascii of course) just the
value of HZ? Then do some trivial calculation off of that.

HZ=$(gethz)

If your 500 was 5 seconds, do

TIME=$[HZ*5]
echo $TIME > /proc/sys/foo/bar/something_in_HZ

I mean, come on.

Then you include it in the default distro of choice so that
everybody can use it and there you are.

If someone doesn't have "gethz" then they can download it.

// Stefan
