Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265718AbUFDKlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbUFDKlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 06:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbUFDKlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 06:41:15 -0400
Received: from [213.146.154.40] ([213.146.154.40]:42657 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265718AbUFDKlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 06:41:12 -0400
Date: Fri, 4 Jun 2004 11:41:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Brian Gerst <bgerst@didntduck.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040604104108.GA30228@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Brian Gerst <bgerst@didntduck.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
	Arjan van de Ven <arjanv@redhat.com>,
	"Siddha, Suresh B" <suresh.b.siddha@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040603072146.GA14441@elte.hu> <40BF201F.2020701@quark.didntduck.org> <20040604093958.GE11034@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604093958.GE11034@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 11:39:58AM +0200, Ingo Molnar wrote:
> I think Wine could get around this by creating a dummy ELF section in
> the Wine binary that covers the first 1GB or so. Wine could still use
> ordinary dynamic libraries - those would go above that 1GB. Then once
> Wine has loaded up it can munmap() that first 1GB.
> 
> (this would not work if Wine has to dlopen() new libraries after this
> phase - does that happen?)

Why can't wine just implement it's own binfmt_pecoff?  Sounds like the
much simpler solutuion.

