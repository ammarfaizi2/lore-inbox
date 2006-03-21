Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWCUV36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWCUV36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWCUV35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:29:57 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:34177 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932459AbWCUV34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:29:56 -0500
Date: Tue, 21 Mar 2006 14:28:53 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Phillip Lougher <phillip@lougher.org.uk>,
       Al Viro <viro@ftp.linux.org.uk>,
       "unlisted-recipients: no To-header on input <;, Jeff Garzik" 
	<jeff@garzik.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
Message-ID: <20060321212853.GV6199@schatzie.adilger.int>
Mail-Followup-To: Phillip Lougher <phillip@lougher.demon.co.uk>,
	Pavel Machek <pavel@ucw.cz>,
	Phillip Lougher <phillip@lougher.org.uk>,
	Al Viro <viro@ftp.linux.org.uk>,
	"unlisted-recipients: no To-header on input <;, Jeff Garzik" <jeff@garzik.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk> <20060321191144.GB3929@elf.ucw.cz> <44205C1A.4040408@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44205C1A.4040408@lougher.demon.co.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 21, 2006  20:03 +0000, Phillip Lougher wrote:
> I don't want the lack of a fixed endianness on disk to become a problem. 
>   I personally don't think the use of, or lack of a fixed endianness to 
> be that important, but I'd prefer not to change the current situation 
> and adopt a fixed format.  I use big endian systems almost exclusively, 
> and I don't like the way fixed formats always tend to be little-endian.

If you want to squeak every last ounce of performance out of the filesystem,
just have it declare two filesystem types - one for the little-endian, and
one for the bit endian.  Generate one of them via "sed" from the other, to
rename the functions, exports, etc, so they don't conflict.  Then, depending
on the superblock magic it will mount the right filesystem, depending on
endianness.  Since they are separate filesystems, normally only one module
or the other need to be loaded at a time, and there is no runtime overhead.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

