Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWDAHjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWDAHjR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 02:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWDAHjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 02:39:17 -0500
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:9737 "EHLO
	mail.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S1750768AbWDAHjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 02:39:16 -0500
Date: Sat, 1 Apr 2006 09:39:07 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: linux-kernel@vger.kernel.org, mike.miller@hp.com
Subject: Problem with diskstats (kernel 2.6.15-gentoo-r1)
Message-ID: <20060401073907.GA29809@shuttle.vanvergehaald.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This morning I discovered a strange problem with the output of
/proc/diskstats; the cciss driver only produces the first 4 fields:

# cat /proc/diskstats
   2    0 fd0 0 0 0 0 0 0 0 0 0 0 0
   1    0 ram0 0 0 0 0 0 0 0 0 0 0 0
   1    1 ram1 0 0 0 0 0 0 0 0 0 0 0
   1    2 ram2 0 0 0 0 0 0 0 0 0 0 0
   1    3 ram3 0 0 0 0 0 0 0 0 0 0 0
   1    4 ram4 0 0 0 0 0 0 0 0 0 0 0
   1    5 ram5 0 0 0 0 0 0 0 0 0 0 0
   1    6 ram6 0 0 0 0 0 0 0 0 0 0 0
   1    7 ram7 0 0 0 0 0 0 0 0 0 0 0
   1    8 ram8 0 0 0 0 0 0 0 0 0 0 0
   1    9 ram9 0 0 0 0 0 0 0 0 0 0 0
   1   10 ram10 0 0 0 0 0 0 0 0 0 0 0
   1   11 ram11 0 0 0 0 0 0 0 0 0 0 0
   1   12 ram12 0 0 0 0 0 0 0 0 0 0 0
   1   13 ram13 0 0 0 0 0 0 0 0 0 0 0
   1   14 ram14 0 0 0 0 0 0 0 0 0 0 0
   1   15 ram15 0 0 0 0 0 0 0 0 0 0 0
   7    0 loop0 0 0 0 0 0 0 0 0 0 0 0
   7    1 loop1 0 0 0 0 0 0 0 0 0 0 0
   7    2 loop2 0 0 0 0 0 0 0 0 0 0 0
   7    3 loop3 0 0 0 0 0 0 0 0 0 0 0
   7    4 loop4 0 0 0 0 0 0 0 0 0 0 0
   7    5 loop5 0 0 0 0 0 0 0 0 0 0 0
   7    6 loop6 0 0 0 0 0 0 0 0 0 0 0
   7    7 loop7 0 0 0 0 0 0 0 0 0 0 0
 104    0 cciss/c0d0 847389 32332 0 2982364 1619046 4086174 0
52598252 0 12069816 55580352
 104    1 cciss/c0d0p1 554 52382 7 20
 104    2 cciss/c0d0p2 29 232 42 336
 104    3 cciss/c0d0p3 84233 5811794 1516187 12129496
 104    4 cciss/c0d0p4 795049 17425244 4190632 33525064
 104   16 cciss/c0d1 86563628 212593 0 655297532 13528298 14360980 0
1485869084 502 371162916 2142684840
 104   17 cciss/c0d1p1 86776123 1102284661 27890200 223121616
   3    0 hda 0 0 0 0 0 0 0 0 0 0 0
 254    0 dm-0 0 0 0 0 0 0 0 0 0 0 0
 254    1 dm-1 0 0 0 0 0 0 0 0 0 0 0
 254    2 dm-2 0 0 0 0 0 0 0 0 0 0 0
 254    3 dm-3 0 0 0 0 0 0 0 0 0 0 0
 254    4 dm-4 0 0 0 0 0 0 0 0 0 0 0
 254    5 dm-5 0 0 0 0 0 0 0 0 0 0 0
 254    6 dm-6 0 0 0 0 0 0 0 0 0 0 0
 254    7 dm-7 0 0 0 0 0 0 0 0 0 0 0

Maybe the cciss maintainer can comment?
Regards,
Toon.
