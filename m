Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265042AbUGBXBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265042AbUGBXBV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265047AbUGBXBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:01:21 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:25266 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S265042AbUGBXBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:01:12 -0400
Mail-Followup-To: SSlota@gmx.net,
  linux-kernel@vger.kernel.org,
  linux-ide@vger.kernel.org,
  jgarzik@pobox.com
MBOX-Line: From george@galis.org  Fri Jul  2 19:01:12 2004
Date: Fri, 2 Jul 2004 19:01:12 -0400
From: George Georgalis <george@galis.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sebastian Slota <SSlota@gmx.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
Message-ID: <20040702230112.GB27065@trot.local>
References: <20040625213433.GB6502@trot.local> <29181.1088498805@www29.gmx.net> <20040630044352.GB8841@trot.local> <40E25AC1.6030302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E25AC1.6030302@pobox.com>
X-Time: trot.local; @0; Fri,  2 Jul 2004 19:01:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 02:16:33AM -0400, Jeff Garzik wrote:
>George Georgalis wrote:
>>I was able to dd ~140 GB with SATA_SIL today, on a stock bk kernel, till
>>I ran out of disk, no errors. which was a pleasant unexpected surprise.
>>
>>but when I checked "Timing buffered disk reads" it was around 25 MB/sec
>>not the ~52 MB/sec I saw before with the oops. The odd thing was this
>>disk was not in the blacklist so I don't know why it was running slower.
>
>
>Try mounting a filesystem, unmounting it, and then doing the timing.

With some new (working) ram in the box, and root on hda; sata_sil
gave pretty consistent 29 MB/sec as an auxiliary sda disk, mounted,
remounted, unmounted, verified 29.50 +/- .40 MB/sec, consistently.

However, when I boot with root on sda, I get better performance (?), up
to 41MB/sec and consistently in the 30s; with x and many daemons (but
unloaded)...

 Timing buffered disk reads:  100 MB in  3.05 seconds =  32.74 MB/sec
 Timing buffered disk reads:  112 MB in  3.04 seconds =  36.84 MB/sec
 Timing buffered disk reads:  114 MB in  3.01 seconds =  37.82 MB/sec
 Timing buffered disk reads:  104 MB in  3.02 seconds =  34.48 MB/sec
 Timing buffered disk reads:  110 MB in  3.00 seconds =  36.64 MB/sec
 Timing buffered disk reads:   94 MB in  3.01 seconds =  31.19 MB/sec
 Timing buffered disk reads:   88 MB in  3.01 seconds =  29.25 MB/sec
 Timing buffered disk reads:   90 MB in  3.06 seconds =  29.37 MB/sec
 Timing buffered disk reads:   88 MB in  3.01 seconds =  29.23 MB/sec
 Timing buffered disk reads:  108 MB in  3.03 seconds =  35.70 MB/sec
 Timing buffered disk reads:  120 MB in  3.04 seconds =  39.47 MB/sec
 Timing buffered disk reads:   88 MB in  3.00 seconds =  29.30 MB/sec

(more or less random intervals, at least 5 seconds apart), this
is running a bk kernel checked out June 28. I've written up to 200Gb
to this disk and built a workstation on it, no errors.

Thanks!
// George


-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

