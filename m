Return-Path: <linux-kernel-owner+w=401wt.eu-S932216AbXAFVIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbXAFVIs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 16:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbXAFVIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 16:08:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:53331 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932216AbXAFVIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 16:08:48 -0500
Date: Sat, 6 Jan 2007 22:08:26 +0100
From: Marcus Meissner <meissner@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@codemonkey.org.uk>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: revert PIE randomization?
Message-ID: <20070106210826.GA31518@suse.de>
References: <Pine.LNX.4.64.0701062005001.22171@blonde.wat.veritas.com> <Pine.LNX.4.64.0701061303320.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701061303320.3661@woody.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 01:04:02PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 6 Jan 2007, Hugh Dickins wrote:
> > 
> > Isn't that randomization, anywhere from 0x10000 to ELF_ET_DYN_BASE,
> > sure to place the ET_DYN from time to time just where the comment says
> > it's trying to avoid?  I assume that somehow results in the error reported.
> 
> Hmm.. It's certainly the case that it would appear that the randomization 
> might put the binary just under the heap, and cause conflicts with brk 
> and the mmap heap.
> 
> You're right. I'm inclined to just revert it, modulo some comments from 
> others. Marcus?

After thinking about this, yes.

I would rather have a working range used here (perhaps like Hugh suggested),
but feel free to revert the original patch if you are not confident with it.

Ciao, Marcus
