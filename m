Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVCMTgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVCMTgI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 14:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVCMTgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 14:36:07 -0500
Received: from mailhub3.nextra.sk ([195.168.1.146]:38158 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261439AbVCMTfa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 14:35:30 -0500
Message-ID: <4234965C.1010502@rainbow-software.org>
Date: Sun, 13 Mar 2005 20:37:00 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
CC: Grzegorz Kulewski <kangur@polcom.net>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
References: <42348474.7040808@aknet.ru> <Pine.LNX.4.62.0503131950190.23588@alpha.polcom.net> <42349068.4030405@aknet.ru>
In-Reply-To: <42349068.4030405@aknet.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> Hello.
> 
> Grzegorz Kulewski wrote:
> 
>> Does the bug also egsist on AMD CPU's?
> 
> Yes. As well as the ones of a Transmeta etc.
> I just haven't tested the old Cyrixes, that
> AFAIK were trying to ignore some Intel bugs.
> The test-case for the bug is here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/0690.html

I've just ran that on my Cyrix MII PR300 and the bug is present:
old_ss=0x7b new_ss=0x7f
In sighandler: esp=bffff780
old_esp=0xbffff780 new_esp=0xc1a6f780
BUG!

I have also an older Cyrix CPU - 6x86 PR166 - but can't test it now as 
it's sitting in a plastic box on the shelf :-)

UMC U5SX/33 in my router - also present:
old_ss=0x7b new_ss=0x7f
In sighandler: esp=bffff820
old_esp=0xbffff820 new_esp=0xc003f820
BUG!


-- 
Ondrej Zary
