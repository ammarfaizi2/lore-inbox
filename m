Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVGINJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVGINJi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 09:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVGINJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 09:09:38 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:30142 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261370AbVGINJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 09:09:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y6MGnN+mSwL4elkayo29spXqMc47J1/7QL/byx4o/3xS0kt5pKF6N38ZiVS3UQnE4J6cKw6RuvWyaDTjr4qluzwNduYf02OaAQBKZrF5waZuksiF56bjDH7MVBnyt3OA0PDH2iTWW9jxFaH8t7aL47JuSCRzNbxlCj2Lzg43LOc=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.13-rc2-mm1: some speakup nitpicks
Date: Sat, 9 Jul 2005 17:16:21 +0400
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, kirk@braille.uwo.ca,
       linux-kernel@vger.kernel.org, speakup@braille.uwo.ca, gregkh@suse.de
References: <20050707040037.04366e4e.akpm@osdl.org> <20050709020717.GQ3671@stusta.de>
In-Reply-To: <20050709020717.GQ3671@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507091716.22334.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 July 2005 06:07, Adrian Bunk wrote:
> - SPEAKUP_DEFAULT shouldn't be asked if SPEAKUP=n
> - "make namespacecheck" shows tons of needlessly global code
> - the static variable special_handler is EXPORT_SYMBOL'ed
> - #define MIN should be removed
> - the file cvsversion.h only for keeping a CVS date is a bit
>   overkill
> - spk_con_module.h is not exactly how we use header files in the kernel
> - many of the #ifdef MODULE's point to things that could be done better
>   (especially the #include "mod_code.c"'s)
> - the things in synthlist.h could be done less ugly
> - speakupconf is a userspace script that belongs under Documentation/
> - dtload.c is not kernel code, and should therefore not be in that
>   directory
> - the code should follow Documentation/CodingStyle better
>   (no spaces between the braces and function arguments)
> - building speakup_keyhelp.c modular even in a kernel that doesn't
>   support modules is silly
> - #include <linux/...> belongs before #include <asm/...>

- Plenty, plenty of sparse warnings.
-	#define PROC_READ_PROTOTYPE char *page, char **start, off_t off, \
				int count, int *eof, void *data
	#define PROC_WRITE_PROTOTYPE struct file *file, const char *buffer, \
				u_long count, void *data
-	#define CAP_A 'A'
	#define CAP_Z 'Z'

  and other fun in drivers/char/speakup/spk_priv.h

- LINUX_VERSION_CODE ifdeffery
