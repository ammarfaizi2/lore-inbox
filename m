Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUCRLyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUCRLyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:54:05 -0500
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:32485 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S262541AbUCRLyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:54:01 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Bernd Schubert <bernd-schubert@web.de>, linux-kernel@vger.kernel.org
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Date: Thu, 18 Mar 2004 21:55:57 +1000
User-Agent: KMail/1.5.1
References: <200403181019.02636.ross@datscreative.com.au> <200403181241.42439.bernd-schubert@web.de>
In-Reply-To: <200403181241.42439.bernd-schubert@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403182155.57386.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 21:41, Bernd Schubert wrote:
> Hi,
> 
> I'm just testing your IdleC1Halt patch (didn't reboot yet) with 2.6.4, but 
> there is a problem if apm is enabled in the configuration: 
> 
> arch/i386/kernel/built-in.o(.text+0x10b65): In function `apm_cpu_idle':
> : undefined reference to `default_idle'
> 
> Your patch sets default_idle() static, so its not available in apm.c file. 
> 
Apologies - Unnecessary change, I only use acpi and was cleaning things up.

It should still work fine by removing the static from it as "idle()" get first try.
change
static void default_idle(void) 
back to
void default_idle(void) 

> Usually I compile with acpi and apm support to switch between both in case of 
> an unsual problem, and I think many people also do so.

Please let me know how it goes.

Ross.

> 
> 
> > http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-02/6520.html
> > The KERNEL ARG to invoke it is "idle=C1halt".
> >
> 
> Thanks,
> 	Bernd
> 
> 
> 
> 

