Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbTKZN2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTKZN2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:28:01 -0500
Received: from holomorphy.com ([199.26.172.102]:39613 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263606AbTKZN1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:27:41 -0500
Date: Wed, 26 Nov 2003 05:27:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
Message-ID: <20031126132719.GP8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ihar 'Philips' Filipau <filia@softhome.net>,
	root@chaos.analogic.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos> <3FC3E2F4.4080809@softhome.net> <Pine.LNX.4.53.0311260745190.9601@chaos> <3FC4A8BA.9070907@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC4A8BA.9070907@softhome.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 02:20:58PM +0100, Ihar 'Philips' Filipau wrote:
>   So what do you use then in user space to reliably allocate memory?
>   As to me - memory is a resource. Is it virtual or is it physical - it 
> is still resource. And I need to allocate part of this resource.
>   malloc() uses brk() inside. But brk() is "implementation details". I 
> honestly do not care about them - I just want to be sure that what ever 
> resource I have allocated - I can use it afterwards until I shall free 
> it. POSIX even doesn't mention brk() BTW.
>   If you can hint me any other method to allocate memory without 
> surprises - I will really appreciate.

Non-overcommit is one such method at the kernel level.
mlockall(MCL_CURRENT|MCL_FUTURE) is another (requiring support at both
levels, in addition to administrative grants of privilege).


-- wli
