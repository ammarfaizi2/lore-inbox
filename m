Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbUCRLlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbUCRLlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:41:50 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:62617 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S262550AbUCRLlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:41:47 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: ross@datscreative.com.au, linux-kernel@vger.kernel.org
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Date: Thu, 18 Mar 2004 12:41:42 +0100
User-Agent: KMail/1.5.4
References: <200403181019.02636.ross@datscreative.com.au>
In-Reply-To: <200403181019.02636.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403181241.42439.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm just testing your IdleC1Halt patch (didn't reboot yet) with 2.6.4, but 
there is a problem if apm is enabled in the configuration: 

arch/i386/kernel/built-in.o(.text+0x10b65): In function `apm_cpu_idle':
: undefined reference to `default_idle'

Your patch sets default_idle() static, so its not available in apm.c file. 

Usually I compile with acpi and apm support to switch between both in case of 
an unsual problem, and I think many people also do so.


> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/6520.html
> The KERNEL ARG to invoke it is "idle=C1halt".
>

Thanks,
	Bernd

