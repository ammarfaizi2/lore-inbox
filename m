Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbTBCXDI>; Mon, 3 Feb 2003 18:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbTBCXDI>; Mon, 3 Feb 2003 18:03:08 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:64171 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S266933AbTBCXDH>; Mon, 3 Feb 2003 18:03:07 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030203125449.GB480@elf.ucw.cz>
References: <20030202223009.GA344@elf.ucw.cz>
	<20030203073028.B4C2920BD9@dungeon.inka.de> 
	<20030203125449.GB480@elf.ucw.cz>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Feb 2003 23:12:33 +0000
Message-Id: <1044313953.28406.44.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Subject: Re: Compactflash cards dying?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 12:54, Pavel Machek wrote:
> Ouch... I can't imageine how even VFAT would work on something not
> 8-bit-clean. I doubt FAT only uses 7bits...

So use a pseudo-file-system which lets you store 8-bit data on such a
device storing only 7-bit data. 

It's no less sensible than taking a real flash device and hacking up a
pseudo-file-system which makes it pretend to be a block device, then
using a 'normal' file system on top of that. 

It's just a shame that CF doesn't generally give you real access to the
underlying flash and let you use a real file system designed for the
purpose rather than its silly 'translation layer' :)

-- 
dwmw2

