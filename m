Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRLQRkg>; Mon, 17 Dec 2001 12:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRLQRk0>; Mon, 17 Dec 2001 12:40:26 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:24061 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281780AbRLQRkN>;
	Mon, 17 Dec 2001 12:40:13 -0500
Date: Mon, 17 Dec 2001 10:40:03 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Hubert Mantel <mantel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: amber/mars & ext3
Message-ID: <20011217104003.N855@lynx.no>
Mail-Followup-To: Hubert Mantel <mantel@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011217161538.GA17099@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011217161538.GA17099@spylog.ru>; from andy@spylog.ru on Mon, Dec 17, 2001 at 07:15:38PM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 17, 2001  19:15 +0300, Andrey Nekrasov wrote:
> 2. dmesg
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160

These are disk read errors.

> EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a
> hole at offset 0
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a
> hole at offset 0
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a
> hole at offset 0
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a
> hole at offset 0
> end_request: I/O error, dev 16:01 (hdc), sector 4160

These are errors because you didn't read anything from the disk.  "hole at
offset 0 for directory #2" means it could not read _anything_ from the
disk for the root directory.  The disk is totally dead it looks like.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

