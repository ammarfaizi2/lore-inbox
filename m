Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWEQHxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWEQHxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWEQHxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:53:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:28007 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750746AbWEQHxL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:53:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rDw4Gx4IF4d0tTQnqP3f4nc3QCM3aBvi612q0tTJRe6+JqsYJR40Mp16qfkV2WTfW0Q6Ddh/uJiGLiVa5UfmQr433yy3YNWizQKTUG0EDESIoQYS4PPFe1tOtjHm2G9dETKuSFat4TN7BYZ7TqdFPIzYEiWKi3j/g/DDmOHP4oQ=
Message-ID: <3aa654a40605170053l317ee7c3q68a83daf358666b9@mail.gmail.com>
Date: Wed, 17 May 2006 00:53:10 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Linux v2.6.17-rc4
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
> If you know of any regressions, please holler now, so that we don't miss
> them.


I wouldn't guess this was intentional, was it?

--- arch/i386/Kconfig   2006-03-28 12:11:29.000000000 -0800
+++ ../linux/arch/i386/Kconfig  2006-05-15 14:51:56.000000000 -0700
@@ -451,7 +467,7 @@

 choice
        depends on EXPERIMENTAL && !X86_PAE
-       prompt "Memory split"
+       prompt "Memory split" if EMBEDDED
        default VMSPLIT_3G
        help
          Select the desired split between kernel and user memory.

-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
