Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVHKCcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVHKCcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVHKCcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:32:17 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:36811
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S932087AbVHKCcQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:32:16 -0400
Date: Thu, 11 Aug 2005 03:32:14 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: Partitioning problems on x86_64 (fwd)
Message-ID: <Pine.LNX.4.58.0508110331360.3920@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Apologies if these are known problems, but I don't recall seeing them
mentioned recently.

 I'm running an athlon64 with 2.6.12.3, in the middle of rebuilding it
to run 64-bit.  The main drive used to be in an i686 machine for
testing, and it got to a point where I wanted to repartition.

 Under a 64-bit kernel, every time I tried to rewrite the partition
table in fdisk I got an error 16, device or resource busy, with a
message that the new partition table would be used at the next boot.
(Yes, I had umounted everything except '/' on hda5. )  Since making a
filesystem on my new /dev/hda7 and mounting it showed the size of the
old hda7 in 'df', I tried rebooting but the failure to rewrite the
partition table continued.

 At one point, I thought I'd try the stronger magic of sfdisk, but that
just reported some error in the number of bytes read, and decided it
couldn't read the partition table.

 In the end I was able to repartition successfully by rebooting to a
2.6.12.1 i686 kernel.  This box is destined to become my new home
server, so running test kernels on it isn't something I'm keen to try,
but I thought I'd better report this, and the successful workaround of
using an i686 kernel, which will be a bit of a pain on pure64.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

