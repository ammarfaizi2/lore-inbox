Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbTCZUPg>; Wed, 26 Mar 2003 15:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbTCZUPg>; Wed, 26 Mar 2003 15:15:36 -0500
Received: from holomorphy.com ([66.224.33.161]:29095 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262061AbTCZUPf>;
	Wed, 26 Mar 2003 15:15:35 -0500
Date: Wed, 26 Mar 2003 12:26:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: ravikumar.chakaravarthy@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to turn paging on!!
Message-ID: <20030326202627.GM30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	ravikumar.chakaravarthy@amd.com, linux-kernel@vger.kernel.org
References: <99F2150714F93F448942F9A9F112634CA54B3A@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634CA54B3A@txexmtae.amd.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 01:23:17PM -0600, ravikumar.chakaravarthy@amd.com wrote:
> I tweaked the kernel and boot loader to load the kernel at 0xdf000000, physical address. I did the following changes to setup the initial page table.
> However during boot, in arch/i386/kernel/head.S when the paging bit is set 
>        movl %eax,%cr0          /* ..and set paging (PG) bit */
> My computer hangs!!
> Any idea why??

Well, first off this is probably a virtual address, not a physical
one. I don't know why you're trying to do this, but there are bits in
arch/i386/boot/ that will likely need fixing up for you to do this.
If that's really the physical address you're trying to use you're
going to need a special bootloader and some invasive arch/i386/ changes.


-- wli
