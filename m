Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWBCSXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWBCSXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWBCSXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:23:45 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:5591 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1751314AbWBCSXo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:23:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RAID5 unusably unstable through 2.6.14
Date: Fri, 3 Feb 2006 13:23:43 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C9959@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID5 unusably unstable through 2.6.14
Thread-Index: AcYo7KRKIhh4utIlTsSdi9uBLTilHAAARkTQ
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Martin Drab" <drab@kepler.fjfi.cvut.cz>
Cc: "Phillip Susi" <psusi@cfl.rr.com>, "Bill Davidsen" <davidsen@tmr.com>,
       "Cynbe ru Taren" <cynbe@muq.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab [mailto:drab@kepler.fjfi.cvut.cz] sez:
>       sd 0:0:0:0: SCSI error: return code = 0x8000002
>       sda: Current: sense key: Hardware Error
>           Additional sense: Internal target failure
>       Info fld=0x0
>       end_request: I/O error, dev sda, sector <some sector number>

You reported that the Adaptec management software did not indicate the
array was offline in the Adapter, thus these reports come when there is
a unrecoverable (non-redundant) bad block being read from the physical
media. The alternate to this is that such a condition or similar had
existed in the past, and the media bad block was remapped then marked as
inconsistent (as noted, until a write makes it consistent).

However, such conditions do not make the array inaccessible from dd as
you indicate (unless block 0 is the inconsistent block?); thus the array
must have been offline. Too bad we can not reproduce this, the
management applications must have indicated the array was offline (two
drive + failure).

-- Mark
