Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270313AbUJTNMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270313AbUJTNMe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270068AbUJTNK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:10:29 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:8713 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270205AbUJTNHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:07:23 -0400
Date: Wed, 20 Oct 2004 14:07:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add hook to generic irq code (free_irq)
Message-ID: <20041020130715.GA20287@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
References: <20041020023156.GA8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020023156.GA8597@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 07:31:56PM -0700, Chris Wedgwood wrote:
> This is needed because some architectures (well, presently only UML)
> needs to be notified as things are freed.
> 
> Signed-off-by: cw@f00f.org
> 
> 
> I can't say I'm 100% happy about this, either the name or a somewhat
> ugly hook that is called with a spinlock held but for lack of any
> better suggestions...

This looks rather bogus to me.  What prevents UML from doing it's work
at the struct hw_interrupt_type level?

