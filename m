Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269337AbUJQUPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269337AbUJQUPD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269395AbUJQUPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:15:02 -0400
Received: from holomorphy.com ([207.189.100.168]:3994 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269299AbUJQUNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:13:52 -0400
Date: Sun, 17 Oct 2004 13:13:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org,
       luc@saillard.org, Andrew Morton <akpm@osdl.org>
Subject: Re: rc4-mm1 and pwc-unofficial: kernel BUG and scheduling while atomic [u]
Message-ID: <20041017201335.GC5607@holomorphy.com>
References: <20041017073614.GC7395@gamma.logic.tuwien.ac.at> <20041017093018.GY5607@holomorphy.com> <1098038131.15115.8.camel@nosferatu.lan> <20041017190054.GB5607@holomorphy.com> <1098043065.15115.13.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098043065.15115.13.camel@nosferatu.lan>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 12:00 -0700, William Lee Irwin III wrote:
>> Only the third argument changed, from a physical address to a pfn.

On Sun, Oct 17, 2004 at 09:57:45PM +0200, Martin Schlemmer [c] wrote:
> Its the vesafb-tng patch
> (http://dev.gentoo.org/~spock/projects/vesafb-tng/)
> I did it as:
> 
> ----
>         vma.vm_mm = current->active_mm;
>         vma.vm_page_prot.pgprot = PROT_READ | PROT_EXEC | PROT_WRITE;
> 
>         ret = remap_pfn_range(&vma, 0x000000, __pa(mem) >> PAGE_SHIFT, REAL_MEM_SIZE, vma.vm_page_prot);
>         ret += remap_pfn_range(&vma, 0x0a0000, 0x0a0000, 0x100000 - 0x0a0000, vma.vm_page_prot);

You probably have to shift the physical address in the second call also.


-- wli
