Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVLFVLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVLFVLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVLFVLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:11:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:47598 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965039AbVLFVLw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:11:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Olivier MATZ <zer0@droids-corp.org>
Subject: Re: [PATCH] asm-i386 : config.h should not be included out of kernel
Date: Tue, 6 Dec 2005 22:11:39 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <4395F405.9010107@droids-corp.org>
In-Reply-To: <4395F405.9010107@droids-corp.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512062211.40142.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag 06 Dezember 2005 21:26 schrieb Olivier MATZ:
> @@ -1,9 +1,9 @@
> -#include <linux/config.h>
> -
>  #ifndef _ASMi386_PARAM_H
>  #define _ASMi386_PARAM_H
>  
>  #ifdef __KERNEL__
> +#include <linux/config.h>  /* mustn't include <linux/config.h> outside of
> #ifdef __KERNEL__ */ +

Just drop that line completely, including linux/config.h is no longer 
necessary.

	Arnd <><
