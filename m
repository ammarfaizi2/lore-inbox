Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265719AbUFDKsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbUFDKsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 06:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUFDKsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 06:48:37 -0400
Received: from holomorphy.com ([207.189.100.168]:65188 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265719AbUFDKsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 06:48:35 -0400
Date: Fri, 4 Jun 2004 03:48:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Brian Gerst <bgerst@didntduck.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040604104818.GY21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Brian Gerst <bgerst@didntduck.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
	Arjan van de Ven <arjanv@redhat.com>,
	"Siddha, Suresh B" <suresh.b.siddha@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040603072146.GA14441@elte.hu> <40BF201F.2020701@quark.didntduck.org> <20040604093958.GE11034@elte.hu> <20040604104108.GA30228@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604104108.GA30228@infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 11:39:58AM +0200, Ingo Molnar wrote:
>> I think Wine could get around this by creating a dummy ELF section in
>> the Wine binary that covers the first 1GB or so. Wine could still use
>> ordinary dynamic libraries - those would go above that 1GB. Then once
>> Wine has loaded up it can munmap() that first 1GB.
>> (this would not work if Wine has to dlopen() new libraries after this
>> phase - does that happen?)

On Fri, Jun 04, 2004 at 11:41:08AM +0100, Christoph Hellwig wrote:
> Why can't wine just implement it's own binfmt_pecoff?  Sounds like the
> much simpler solutuion.

I'd be in favor of this also. An executable format with wide enough
usage is worth adding kernel support for loading it.


-- wli
