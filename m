Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424598AbWKKSW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424598AbWKKSW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424599AbWKKSW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:22:56 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:62141 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1424598AbWKKSW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:22:56 -0500
Date: Sat, 11 Nov 2006 19:22:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: printk in user mode program
In-Reply-To: <20061111181141.86824.qmail@web27415.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.61.0611111921460.22893@yvahk01.tjqt.qr>
References: <20061111181141.86824.qmail@web27415.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi all,
>
>I got compilation errors when I compiled the below
>program by the command "gcc 1.c". 

That's not the right way to compile a kernel file. And probably neither 
is for a userspace program (you want at least the -o switch, and most 
likely -Wall)

>
>Note: I inluded printk instead of printf because I
>have to call the executable code, produced by
>compiling the below code, in a kernel module using
>call_usermodehelper().

If you write a userspace program, use userspace functions.

>
> Please help me.
>Thanks in advance.
>
>---------------------------------------------
>#include<stdio.h>
>#include<linux/module.h>
>#include<linux/kernel.h>
>int main(int argc,char **argvp,char **envp)
>{
>int a,b,c,d;
>for(a=0;a<99999;a++)
>for(d=0;d<9;d++)
>//for(b=0;b<9999;b++)
>c++;
>printk(KERN_INFO "USER PROGRAM \n");
>
>return 0;
>
>}
>-------------------------------------------------
>compilation errors:
>
>1.c: In function `main':
>1.c:11: error: `KERN_INFO' undeclared (first use in
>this function)
>1.c:11: error: (Each undeclared identifier is reported
>only once
>1.c:11: error: for each function it appears in.)
>1.c:11: error: syntax error before string constant
>
>
>Send instant messages to your online friends http://uk.messenger.yahoo.com 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

	-`J'
-- 
