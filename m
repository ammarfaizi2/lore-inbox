Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbUKETbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbUKETbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbUKETbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:31:04 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:63104 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261174AbUKETai convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:30:38 -0500
X-OB-Received: from unknown (205.158.62.49)
  by wfilter.us4.outblaze.com; 5 Nov 2004 19:30:31 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com
Date: Fri, 05 Nov 2004 14:30:31 -0500
Subject: ext2/3 issue 2.6 vs 2.4 kernels
X-Originating-Ip: 67.112.215.16
X-Originating-Server: ws1-1.us4.outblaze.com
Message-Id: <20041105193031.8D8924BE65@ws1-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to get filesystem corruption whenever I mount a Fedora 
Core 2 (2.6.5 kernel) with a RedHat 9 rescue CD (2.4.20) or my
other 2.4.18 rescue media and try to chroot to the system image.
I've tried on a few systems so it's not a hardware issue.

Here are the messages I get in dmesg.  They seem file system 
related.

EXT3-fs: mounted filesystem with ordered data mode.
attempt to access beyond end of device
08:02: rw=0, want=1219858868, limit=15767797
attempt to access beyond end of device
08:02: rw=0, want=1219858868, limit=15767797

I haven't been able to reliably reproduce the actual file 
system corruption that I've seen.  Sometimes ls doesn't work
in /bin/ or once I lost everything under /usr.

I've googled for this and I found a redhat bug that might be
related.
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=126730

I have tried with both ext2 and ext3 partitions formatted 
under the 2.6 kernel and I get the same results in both cases.

Has something changed in ext2 and ext3 to make them not 
backward compatible to 2.4 kernels?

regards,
dan carpenter

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

