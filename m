Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTKYABs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTKYAAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:00:20 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:43783
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261807AbTKYAAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:00:05 -0500
Date: Mon, 24 Nov 2003 16:00:02 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       mason@suse.com
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
Message-ID: <20031125000002.GB1586@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	mason@suse.com
References: <20031124224514.56242.qmail@web40908.mail.yahoo.com.suse.lists.linux.kernel> <Pine.LNX.4.58.0311241452550.15101@home.osdl.org.suse.lists.linux.kernel> <p733ccdpbra.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p733ccdpbra.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 12:50:17AM +0100, Andi Kleen wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > The PAGEFREE debug option works well for page allocations, but the slab
> > cache is not very amenable to it. For slab debugging, it would be
> > wonderful if somebody made a _truly_ debugging slab allocator that didn't
> > use the slab cache at all, but used the page allocator (and screw the fact
> > that you use too much memory ;) instead.
> 
> One way to find slab corruptions qickly is to write a thrasher:
> identify for which slab size the corruptions happens and then write a
> small module that runs a thread that just allocates from that slab,
> writes a pattern to it, sleeps a bit, and checks the pattern (allocate
> multiple slabs to make it more effective). Repeat.
> 
> If you don't know the size cycle through the different cache sizes.
> 
> Me and Chris used that to track down some nasty corruptions on x86-64,
> it is especially useful together with LTP which calls a lot of system
> calls that could cause corruption.

Do you have your code posted anywhere, and when are you going to merge it
with LTP? ;)
