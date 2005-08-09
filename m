Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVHIM7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVHIM7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 08:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVHIM7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 08:59:55 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:39085 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932532AbVHIM7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 08:59:54 -0400
Date: Tue, 9 Aug 2005 14:59:47 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
cc: 7eggert@gmx.de, hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Posix file attribute support on VFAT
In-Reply-To: <42F7F998.7080400@sm.sony.co.jp>
Message-ID: <Pine.LNX.4.58.0508091446330.2164@be1.lrz>
References: <4zfoZ-5u4-9@gated-at.bofh.it> <E1E2GAN-0003Pj-2l@be1.lrz>
 <42F7F998.7080400@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Machida, Hiroyuki wrote:
> Bodo Eggert wrote:

> Please confirm my understanding.
> You sugessted that symlink should not have ATTR_SYS, to prevent
> some over 4KB files created in DOS/WIN to be treated as symlinks?

NACK, files longer than 4KB should not be symlinks, and maybe (if you're
paranoid enough) files without a magic header should not be symlinks, too.

BTW: What about storing short symlinks (strlen(name)+strlen(symlink) < 200)
in the filename as $name.modified_base64($symlink) and storing the split
position in ctime? This would reduce the need for data blocks, which may
be valuable on small devices.

-- 
Keep your hands off strong drink. It can make you shoot at the tax collector
and miss.
	-- R.A. Heinlein
