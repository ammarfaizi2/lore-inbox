Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWFUAIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWFUAIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWFUAIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:08:43 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:60625 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751003AbWFUAIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:08:43 -0400
Message-ID: <44988E08.9070000@vmware.com>
Date: Tue, 20 Jun 2006 17:08:40 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       jeremy@xensource.com
Subject: Re: [PATCH 2.6.17] Clean up and refactor i386 sub-architecture setup
References: <44988803.5090305@goop.org>
In-Reply-To: <44988803.5090305@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> From: Jeremy Fitzhardinge <jeremy@xensource.com>
>
> Clean up and refactor i386 sub-architecture setup.
>
> This change moves all the code from the 
> asm-i386/mach-*/setup_arch_pre/post.h headers, into 
> arch/i386/mach-*/setup.c.  mach-*/setup_arch_pre.h is renamed to 
> setup_arch.h, and contains only things which should be in header 
> files.  It is purely code-motion; there should be no functional 
> changes at all.
>
> Several functions in arch/i386/kernel/setup.c needed to be made 
> non-static so that they're visible to the code in mach-*/setup.c. 
> asm-i386/setup.h is used to hold the prototypes for these functions.

This looks awesome.   Are there any plans to get these sub-architectures 
to work with the generic subarch?  Seems the next logical step would be 
putting each mach-*/*.o into separated namespaces.

Zach
