Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWIKPeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWIKPeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWIKPeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:34:05 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:14342 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751306AbWIKPeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:34:02 -0400
Subject: Re: [PATCH 2/3] FRV: Permit __do_IRQ() to be dispensed with
From: Daniel Walker <dwalker@mvista.com>
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <7359.1157968022@warthog.cambridge.redhat.com>
References: <20060909051211.GA6922@elte.hu>
	 <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com>
	 <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com>
	 <7359.1157968022@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 08:33:57 -0700
Message-Id: <1157988838.3516.7.camel@c-67-169-176-11.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 10:47 +0100, David Howells wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > The real solution would be to use gcc -ffunction-sections plus ld 
> > --gc-sections to automatically get rid of unused global functions, at 
> > link time.
> 
> It's easy.  It's already possible with FRV.  Just add the attached patch and
> enable the new option.  However, you also need to compile without debugging
> code, otherwise it has little effect.  I think stabs links bring stuff in or
> something.
> 

It's a wide spread problem so I think something more generic is
appropriate.

Does the code in Marcelo's patch make sense for FRV, or vis-versa?

Daniel

