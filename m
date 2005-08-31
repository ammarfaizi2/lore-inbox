Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVHaMZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVHaMZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVHaMZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:25:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20717 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932513AbVHaMZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:25:27 -0400
Date: Wed, 31 Aug 2005 08:25:13 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Matteo <kundor@kundor.org>, linux-kernel@vger.kernel.org
Subject: Re: MAX_ARG_PAGES has no effect?
Message-ID: <20050831122512.GZ7403@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <4314F761.2050908@kundor.org> <20050831121144.GA13578@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831121144.GA13578@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 02:11:44PM +0200, Ingo Molnar wrote:
> > I recompiled and installed the kernel, but there's no change (getconf 
> > ARG_MAX still gives 131072.)  What am I missing?
> 
> MAX_ARG_PAGES should work just fine. I think the 'getconf ARG_MAX' 
> output is hardcoded. (because the kernel does not provide the 
> information dynamically)

Yeah, you get the value of ARG_MAX from <linux/limits.h> that was compiled
in when you compiled glibc.

	Jakub
