Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265745AbUEZRpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUEZRpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265739AbUEZRpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:45:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265745AbUEZRof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 13:44:35 -0400
Date: Wed, 26 May 2004 09:59:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Doug Dumitru <doug@easyco.com>, linux-kernel@vger.kernel.org
Subject: Re: Hard Hang with __alloc_pages: 0-order allocation failed (gfp=0x20/1) - Not out of memory
Message-ID: <20040526125921.GJ6439@logos.cnet>
References: <40B3C816.6030802@easyco.com> <20040525161212.6478216e.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525161212.6478216e.davem@redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 04:12:12PM -0700, David S. Miller wrote:
> On Tue, 25 May 2004 15:26:30 -0700
> Doug Dumitru <doug@easyco.com> wrote:
> 
> > This is the original trap dump from a __page_alloc error
> > 
> > __alloc_pages: 0-order allocation failed (gfp=0x20/1)
> 
> 0x20 means GFP_ATOMIC which means it's fine to fail
> and e1000 is doing nothing wrong.  GFP_ATOMIC in interrupts
> is a fine condition.

Yeap, but the crash is not a fine condition... I suspect
what can be happening is extreme gigabit traffic resulting in 
memory shortage.

Doug said the load average is really high. Doug, you're not
using NAPI, right? Can you try it?
