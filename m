Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWFNGiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWFNGiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 02:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWFNGiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 02:38:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:45778 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751091AbWFNGiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 02:38:25 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH 1/2] (resend) x86_64 stack overflow debugging
Date: Wed, 14 Jun 2006 08:38:18 +0200
User-Agent: KMail/1.9.3
Cc: "Jan Beulich" <jbeulich@novell.com>, "Eric Sandeen" <sandeen@sgi.com>,
       linux-kernel@vger.kernel.org
References: <20060613194322.D0CDC10CC671@attica.americas.sgi.com> <448FC7C0.76E4.0078.0@novell.com>
In-Reply-To: <448FC7C0.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606140838.18891.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 June 2006 08:24, Jan Beulich wrote:
> Are you certain you will ever see this trigger? Assembly code switches to the special interrupt handling stack prior to calling do_IRQ(), so I can't see how you would ever find yourself on the process stack in stack_overflow_check(). Jan

The point of the code is to sample the original process stack
and check if the code there is a stack pig, not the interrupt. 

I'm not sure it would be worth adding a special check for irqstack/exception
stacks because nesting there should be pretty rare. Probably not.

-Andi
