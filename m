Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161710AbWKHTKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161710AbWKHTKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161709AbWKHTKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:10:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54715 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161707AbWKHTKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:10:49 -0500
Date: Wed, 8 Nov 2006 11:10:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: "Yinghai Lu" <yinghai.lu@amd.com>, "Greg KH" <gregkh@suse.de>,
       "Andi Kleen" <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
Message-Id: <20061108111041.09adcee2.akpm@osdl.org>
In-Reply-To: <m18xil4x8j.fsf@ebiederm.dsl.xmission.com>
References: <86802c440611032127u33442a33ufc4cf3b11e9b8c7a@mail.gmail.com>
	<20061106140432.44d3c19f.akpm@osdl.org>
	<m18xil4x8j.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 11:19:40 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Fri, 3 Nov 2006 21:27:35 -0800
> > "Yinghai Lu" <yinghai.lu@amd.com> wrote:
> >
> >> For co-prcessor with mem installed, the ram will be treated to pref mem.
> >
> > What is "pref mem"?
> 
> Memory mapped base address registers can be either normal or for prefetchable
> sections of memory mapped I/O.  Frequently all prefetchable bars are 64bit.
> The prefetchable bars are also frequently ask for the largest amounts of
> memory.  So it is easy and worthwhile to place all prefetchable bars about 4G.
> 
> The "pref mem" short hand comes from a the LinuxBIOS print statements that
> report every bar value and what kind of bar it is, during boot up.
> 

Ah.  Prefetchable.  Thanks.

I've basically given up in exhaustion on that patch.  Maybe when I have a
burst of extra energy I'll go back and take the time to understand it,
or maybe when Greg comes back he'll save me.

