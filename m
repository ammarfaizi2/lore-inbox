Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVJYJn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVJYJn2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 05:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVJYJn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 05:43:28 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:9254 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932107AbVJYJn1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 05:43:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iNX7N9jhZ1ciqTlSfaAeV63/c2xHvy7mJ5eEjVP7e/a7ZM5E8A3djgYoBqQkLpQQ/Ez9Jw4gHoLWYqkhIuXc6KqoJhT91tejn15hMbSmuxbKBUWYZyt6QSLivSn2VI/xyRUf3x6l7iTK2vYXvCsznnut/bB8Jzfo5uGV5y7eyjc=
Message-ID: <64c763540510250243v64c0c22bt4a6e57bb5490fb77@mail.gmail.com>
Date: Tue, 25 Oct 2005 15:13:27 +0530
From: Block Device <blockdevice@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Block I/O sizes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I've added a jprobe to generic_make_request and am print(k)ing the
bio->bi_sector and
   bio_sectors(bio) for every bio.

   I expected that for every bio thus printed the bi_sector would be
in terms of sector size.
   But this is apparently not the case.

    When any fs i/o is done, the bi_sector value is in terms of fs
block size and not sector size (for the block device). When i perform
raw i/o to the device ( dd for eg ), bi_sector is in terms of sectors
and not fs blocks.

    In both the cases though, bio_sectors(bio) returns the amount of
data written in sectors.

To me this is rather strange. Should it not be in terms of sector size always ?
 Can someone please explain ?

Thanks
-BD
