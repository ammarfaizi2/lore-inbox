Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161390AbWKHSUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161390AbWKHSUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbWKHSUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:20:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14479 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1754629AbWKHSUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:20:09 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: "Yinghai Lu" <yinghai.lu@amd.com>, "Greg KH" <gregkh@suse.de>,
       "Andi Kleen" <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
References: <86802c440611032127u33442a33ufc4cf3b11e9b8c7a@mail.gmail.com>
	<20061106140432.44d3c19f.akpm@osdl.org>
Date: Wed, 08 Nov 2006 11:19:40 -0700
In-Reply-To: <20061106140432.44d3c19f.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 6 Nov 2006 14:04:32 -0800")
Message-ID: <m18xil4x8j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Fri, 3 Nov 2006 21:27:35 -0800
> "Yinghai Lu" <yinghai.lu@amd.com> wrote:
>
>> For co-prcessor with mem installed, the ram will be treated to pref mem.
>
> What is "pref mem"?

Memory mapped base address registers can be either normal or for prefetchable
sections of memory mapped I/O.  Frequently all prefetchable bars are 64bit.
The prefetchable bars are also frequently ask for the largest amounts of
memory.  So it is easy and worthwhile to place all prefetchable bars about 4G.

The "pref mem" short hand comes from a the LinuxBIOS print statements that
report every bar value and what kind of bar it is, during boot up.

Eric
