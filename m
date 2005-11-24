Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbVKXSGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbVKXSGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 13:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbVKXSGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:06:16 -0500
Received: from hermes.domdv.de ([193.102.202.1]:16399 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S932640AbVKXSGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:06:16 -0500
Message-ID: <43860117.3030609@domdv.de>
Date: Thu, 24 Nov 2005 19:06:15 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tiny improvement to x86_64 asm aes encryption
References: <200511241242.35294.vda@ilport.com.ua>
In-Reply-To: <200511241242.35294.vda@ilport.com.ua>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
[snip]
> #define encrypt_round1(TAB,OFFSET) \
>         round(TAB,OFFSET,R1,R2,R3,R4,R5,R6,R7,R10,R5,R6,R3,R4)
>                          ^^^^^                    ^^^^^
> #define encrypt_round2(TAB,OFFSET) \
>         round(TAB,OFFSET,R5,R6,R3,R4,R1,R2,R7,R10,R1,R2,R3,R4)
>                          ^^^^^                    ^^^^^

Won't work. You don't have "%sh", "%sl", "dh" (*) and "%dl" (*) as
registers.
(*) from %edi
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
