Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbUKCVSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbUKCVSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbUKCVQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:16:11 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:54797 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261879AbUKCVLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:11:36 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: vlobanov <vlobanov@speakeasy.net>
Subject: Re: [TRIVIAL PATCH] /init/version.c
Date: Wed, 3 Nov 2004 23:11:21 +0200
User-Agent: KMail/1.5.4
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0411022359001.17128@shell2.speakeasy.net> <200411031229.31412.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0411030828560.4892@shell1.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0411030828560.4892@shell1.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411032311.21820.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 18:34, vlobanov wrote:
> It seems to compile just fine. Here are the relevant snippets:
> 
>   UPD     include/asm-i386/asm_offsets.h
>   CC      init/main.o
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   CC      init/do_mounts.o
> 
> ...and...
> 
>   CC      fs/proc/proc_tty.o
>   CC      fs/proc/proc_misc.o
>   CC      fs/proc/kcore.o
> 
> Why did you believe it would not compile? (Just so I can be extra
> careful about this kind of code in the future.)

I was wrong. It compiles but won't work right:

a.c:
char msg[] = "boo";

b.c:
#include <stdio.h>
extern char *msg;
int main() {
	puts(msg);
	return 0;
}

# gcc b.c a.c
# ./a.out
Segmentation fault

--
vda

