Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286419AbRLTWZ2>; Thu, 20 Dec 2001 17:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286421AbRLTWZS>; Thu, 20 Dec 2001 17:25:18 -0500
Received: from 216-175-173-2.client.dsl.net ([216.175.173.2]:3837 "HELO
	mail.fdfl") by vger.kernel.org with SMTP id <S286419AbRLTWZJ>;
	Thu, 20 Dec 2001 17:25:09 -0500
Message-ID: <3C226543.2010801@frontierd-us.com>
Date: Thu, 20 Dec 2001 17:25:07 -0500
From: Jelle Foks <jelle@frontierd-us.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011014
X-Accept-Language: en-us
MIME-Version: 1.0
To: Denis RICHARD <dri@sxb.bsf.alcatel.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New version of e2compr for 2.4.16 kernel.
In-Reply-To: <3C2098D7.4228B2A5@sxb.bsf.alcatel.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis RICHARD wrote:

>Hi,
>
>  We have developped a new version of the e2compr package for the 2.4.16 kernel.
>

Nice. Since ext3fs is based on ext2fs, will that work with ext3fs too?

cya,

Jelle.

>
>It is based on the e2compr-0.4.39 patch provided by Peter Moulder
>for 2.2.18 kernel (http://cvs.bofh.asn.au/e2compr/).
>  It is full compatible with previous version.
>
>  We have introduced the structure of "cluster of pages", as there was the structure
>of "cluster of blocks" in preceding version. The compression unit is the cluster of
>pages.
>
>  The implementation is similar with the 2.2 version. If the page needed is not present
>in memory, the cluster of pages including this one is decompressed.
>  But in the 2.4 kernel the pages and the blocks have common area for the data.
>If a block is read from the device, the corresponding page is also modified.
>Then to decompress a cluster we should not read the blocks in the already used pages (decompressed)
>of the cluster. These pages can have been modified or can be used by another process (mapping).
>If a page is UPTODATE, a new one is allocated to decompress the cluster, and is freed after that.
>
>  It has only been tested on i386 architecture, so be careful if you want to try it
>on other architecture, and especially if pages are large and can belong to two different
>clusters.
>
>  For more informations, see the README files in Documentation/filesystems directory.
>
>  If someone is interested by the patch, we will mail it.
>
>  Feel free to contat us if you have some questions.
>
>  Have fun.
>
> Pierre PEIFFER, Denis RICHARD .
>
>PS : We have also adjusted the e2fsprogs patch for the last version (1.25).
>
>--
>-----------------------------\--------------------------\
>Denis RICHARD                 \ ALCATEL Business Systems \
>mailto:dri@sxb.bsf.alcatel.fr / Tel: +33(0)3 90 67 69 36 /
>-----------------------------/--------------------------/
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



