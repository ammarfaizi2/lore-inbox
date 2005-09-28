Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVI1SdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVI1SdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVI1SdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:33:24 -0400
Received: from nevyn.them.org ([66.93.172.17]:28319 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750719AbVI1SdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:33:23 -0400
Date: Wed, 28 Sep 2005 14:33:22 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Message-ID: <20050928183322.GA15021@nevyn.them.org>
Mail-Followup-To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>,
	linux-kernel@vger.kernel.org
References: <21FFE0795C0F654FAD783094A9AE1DFC086F02D1@cof110avexu4.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC086F02D1@cof110avexu4.global.avaya.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 12:06:21PM -0600, Davda, Bhavesh P (Bhavesh) wrote:
> > Yes, I entirely understand what you're saying.  I feel like you're not
> > reading my responses.  GDB _already has a list of signals it does not
> > care about_.  If ptrace permitted, it could tell the kernel not to
> > context switch to deliver those signals.  In advance!  That's a
> > debugger-driven solution to your problem.
> > 
> > I'm not arguing out of theory here.  I've implemented this mechanism
> > before in other contexts, for instance to prevent the remote protocol
> > overhead for ignored signals when using gdb with gdbserver.
> > 
> 
> 
> Okay, I'll come up with an alternative patch that enhances the ptrace
> interface so the debugger can guide the kernel to NOT context switch and
> bother it about signal x from task y.
> 
> Would you be amenable to such a patch?

Yes, definitely.  I just hadn't found a chance to think about what the
interface should look like.

[For the record, I'm pretty sure that the Solaris procfs debug
interface offers a similar feature.]

-- 
Daniel Jacobowitz
CodeSourcery, LLC
