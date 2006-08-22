Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWHVTZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWHVTZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWHVTZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:25:25 -0400
Received: from mail0.lsil.com ([147.145.40.20]:41126 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751190AbWHVTZY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:25:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: HELP: GIT Cloning failed
Date: Tue, 22 Aug 2006 13:25:23 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E35B@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HELP: GIT Cloning failed
Thread-Index: AcbGILZ87Cy8vC1iTYieANrPv7RILA==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: <git@vger.kernel.org>
Cc: "Patro, Sumant" <Sumant.Patro@engenio.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Aug 2006 19:25:23.0965 (UTC) FILETIME=[B71752D0:01C6C620]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently, I found that cloning from GIT server has been failed.
I'm using following script for it.
---
...
rm -r /home/git/kernels/2.4/linux-2.4.git
cg-clone
http://www.kernel.org/pub/scm/linux/kernel/git/marcelo/linux-2.4.git/
/home/git/kernels/2.4/linux-2.4.git/
sync
rm -r /home/git/kernels/2.4/linux-2.6.git
cg-clone
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
/home/git/kernels/2.4/linux-2.6.git/
sync
rm -r /home/git/kernels/2.4/scsi-misc-2.6.git
cg-clone
http://www.kernel.org/pub/scm/linux/kernel/git/marcelo/scsi-misc-2.6.git
/home/git/kernels/2.4/scsi-misc-2.6.git
sync
...
---

In the script, I'm cloning 3 different sources. First two sources
getting successfully cloned, however, last one is getting failed with
following error messages,
---
Fetching head...
Fetching objects...
Getting alternates list for
http://www.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
Also look at http://www.kernel.or
Error: The requested URL returned error: 502 (curl_result = 22,
http_code = 502, sha1 = 1039f0760e...)
Getting pack list for
http://www.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git/
Getting pack list for http://www.kernel.or
Error: The requested URL returned error: 502
Error: Unable to find 27fd37621... Under
http://www.kernel.org/pub/scsm/linux/kernel/git/jejb/scsi-misc-2.6.git/
Cannot obtain needed blob 27fd37621...
While processing commit 4041b9cd87...
Progress: 8 objects, 13120 bytes
Cg-fetch: objects fetch failed
---

Above script worked without any problem when I started several months
ago and I'm not sure when did it stop working.
I'm using _cron_ utility on my Linux box for scheduled execution of the
script.

Any comment would be appreciated.

Thank you,

Seokmann
