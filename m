Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318378AbSGRVQC>; Thu, 18 Jul 2002 17:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318379AbSGRVQC>; Thu, 18 Jul 2002 17:16:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39689 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318378AbSGRVQC>;
	Thu, 18 Jul 2002 17:16:02 -0400
Date: Thu, 18 Jul 2002 22:18:59 +0100
From: Matthew Wilcox <willy@debian.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Matthew Wilcox <willy@debian.org>, jsimmons@transvirtual.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718221859.Q13352@parcelfarce.linux.theplanet.co.uk>
References: <B4822306FB3@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B4822306FB3@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Jul 18, 2002 at 11:04:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:04:54PM +0200, Petr Vandrovec wrote:
> You have enabled CONFIG_VT without CONFIG_VGA_CONSOLE and 
> CONFIG_DUMMY_CONSOLE. It is illegal configuration.

Huh.  So CONFIG_VT_CONSOLE is not enough any more?  I really do think
this should be documented in Config.help.

> To fix oopses, either enable 'Framebuffer devices' under 'Console
> drivers' section (you do not have to enable any fbdev driver, just
> check this option...), or disable CONFIG_VT. See arch/*/kernel/setup.c
> for explanation, no code in VT subsystem kernel expects conswitchp == NULL,
> but couple of architectures leaves sometime conswitchp uninitialized.

well, this is on x86 ...

-- 
Revolutions do not require corporate support.
