Return-Path: <linux-kernel-owner+w=401wt.eu-S932236AbXAFVy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbXAFVy2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 16:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbXAFVy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 16:54:28 -0500
Received: from cantor2.suse.de ([195.135.220.15]:54466 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236AbXAFVy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 16:54:27 -0500
Date: Sat, 6 Jan 2007 22:54:17 +0100
From: Marcus Meissner <meissner@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@codemonkey.org.uk>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: revert PIE randomization?
Message-ID: <20070106215417.GA13541@suse.de>
References: <Pine.LNX.4.64.0701062005001.22171@blonde.wat.veritas.com> <Pine.LNX.4.64.0701061303320.3661@woody.osdl.org> <20070106210826.GA31518@suse.de> <20070106214505.GA8904@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106214505.GA8904@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 10:45:05PM +0100, Ingo Molnar wrote:
> 
> * Marcus Meissner <meissner@suse.de> wrote:
> 
> > > You're right. I'm inclined to just revert it, modulo some comments 
> > > from others. Marcus?
> > 
> > After thinking about this, yes.
> > 
> > I would rather have a working range used here (perhaps like Hugh 
> > suggested), but feel free to revert the original patch if you are not 
> > confident with it.
> 
> i'm wondering why you had to try to reinvent the wheel, instead of 
> picking up exec-shield's remaining bits of randomization implementation 
> from Fedora, which was tested for a long time and achieves PIE 
> randomization and more?

Because it is i386 only last time I checked.

And it requires relaying out the heap (which you did only for i386), with
architecture specific code, which I was too afraid to touch.

Ciao, Marcus
