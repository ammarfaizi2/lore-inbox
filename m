Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbTBJGx1>; Mon, 10 Feb 2003 01:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbTBJGx1>; Mon, 10 Feb 2003 01:53:27 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:55690 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S263326AbTBJGx0>; Mon, 10 Feb 2003 01:53:26 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Nandakumar NarayanaSwamy <nanda_kn@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030210054816.6191.qmail@webmail27.rediffmail.com>
References: <20030210054816.6191.qmail@webmail27.rediffmail.com>
Organization: 
Message-Id: <1044860584.2943.264.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 10 Feb 2003 07:03:04 +0000
Subject: Re: Re: File systems in embedded devices
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-10 at 05:48, Nandakumar NarayanaSwamy wrote:
> I sent it correctly after typing the full mail. I think this is 
> some problem in rediff mails itself.

No, I was being sarcastic. There's no text below your quotation in this
mail from you either. It's all at the top. Please don't do that.

You are still violating 
	http://www.infradead.org/~dwmw2/email.html#references
	http://www.infradead.org/~dwmw2/email.html#top-posting
	http://www.infradead.org/~dwmw2/email.html#quote-selectively
and probably also to a certain extent
	http://www.infradead.org/~dwmw2/email.html#include

> Anyway these are the my requirements:
> 
> 1) My application is coming around 8 MB. So need a file system 
> about 12 MB to which i should be able to mount the root of the 
> Linux kernel.
> 
> 2) I need read-only file system.

If you really only need it to be read-only, and assuming NOR flash, then
cramfs on a flash device sounds like a sane option. If you have NAND
flash then it's slightly more complicated -- you probably need a real
writable file system which deals with NAND but you could use it in
read-only mode.

> 3) Is it possible to create multiple ram disks of multiple file 
> systems like CRAMFS, RAMDISK for a single kernel?

Why? Where would these ramdisks be loaded from in the first place?
Wouldn't you do better to use them directly from there rather than
copying them into precious RAM?

-- 
dwmw2

