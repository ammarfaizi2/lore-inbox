Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWFHNFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWFHNFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 09:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWFHNFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 09:05:46 -0400
Received: from ns1.suse.de ([195.135.220.2]:21672 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964832AbWFHNFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 09:05:45 -0400
To: Voluspa <lista1@comhem.se>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, diegocg@gmail.com,
       linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: adaptive readahead overheads
References: <349406446.10828@ustc.edu.cn>
	<20060604020738.31f43cb0.akpm@osdl.org>
	<1149413103.3109.90.camel@laptopd505.fenrus.org>
	<20060605031720.0017ae5e.lista1@comhem.se>
	<349562623.17723@ustc.edu.cn>
	<20060608094356.5c1272cc.lista1@comhem.se>
	<349766648.27054@ustc.edu.cn>
	<20060608142556.2e10e379.lista1@comhem.se>
From: Andi Kleen <ak@suse.de>
Date: 08 Jun 2006 15:05:38 +0200
In-Reply-To: <20060608142556.2e10e379.lista1@comhem.se>
Message-ID: <p73ac8nu7a5.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa <lista1@comhem.se> writes:

> On Thu, 8 Jun 2006 19:37:31 +0800 Fengguang Wu wrote:
> > I'd like to show some numbers on the pure software overheads come with
> > the adaptive readahead in daily operations.
> [...]
> > 
> > # time find /usr -type f -exec md5sum {} \; >/dev/null
> > 
> > ARA
> > 
> > 406.00s user 325.16s system 97% cpu 12:28.17 total
> 
> Just out of interest, all your figures show an almost maxed out CPU.

It might be because qemu has a poor IO model (old IDE) that is quite 
CPU intensive to drive.

-Andi
