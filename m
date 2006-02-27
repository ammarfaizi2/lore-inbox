Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWBZVWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWBZVWs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWBZVWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:22:48 -0500
Received: from kanga.kvack.org ([66.96.29.28]:10964 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750784AbWBZVWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:22:47 -0500
Date: Sun, 26 Feb 2006 18:22:54 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Largret <largret@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOM-killer too aggressive?
Message-ID: <20060227002254.GA4393@dmt.cnet>
References: <5KvnZ-4uN-27@gated-at.bofh.it> <4401F5E3.3090003@shaw.ca> <20060226215627.GB4979@dmt.cnet> <1140987370.5178.9.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140987370.5178.9.camel@shogun.daga.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 12:56:10PM -0800, Chris Largret wrote:
> On Sun, 2006-02-26 at 15:56 -0600, Marcelo Tosatti wrote:
> > On Sun, Feb 26, 2006 at 12:39:31PM -0600, Robert Hancock wrote:
> > > I think the big question is who used up all the DMA zone.. Surely not 
> > > the floppy driver..
> > 
> > The kernel text and data? "readelf -S vmlinux" output would be useful.
> 
> $ readelf -S vmlinux
> There are 52 section headers, starting at offset 0x2548488:

<snip>

>   [49] .shstrtab         STRTAB           0000000000000000  02548212
>        0000000000000273  0000000000000000           0     0     1
>   [50] .symtab           SYMTAB           0000000000000000  02549188
>        00000000000b3898  0000000000000018          51   20791     8
>   [51] .strtab           STRTAB           0000000000000000  025fca20
>        0000000000096692  0000000000000000           0     0     1

More than 40MB, that should partially explain it...
