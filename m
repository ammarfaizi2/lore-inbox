Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUDOTZU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUDOTZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:25:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:61146 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262481AbUDOTYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:24:37 -0400
Date: Thu, 15 Apr 2004 12:24:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: drepper@redhat.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: message queue limits
Message-Id: <20040415122411.0bcb9195.akpm@osdl.org>
In-Reply-To: <20040415145350.GF2085@logos.cnet>
References: <407A2DAC.3080802@redhat.com>
	<20040415145350.GF2085@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> On Sun, Apr 11, 2004 at 10:48:28PM -0700, Ulrich Drepper wrote:
>  > Something has to change in the way message queues are created.
>  > Currently it is possible for an unprivileged user to exhaust all mq
>  > slots so that only root can create a few more.  Any other unprivileged
>  > user has no change to create anything.
>  > 
>  > I think it is necessary to create a per-user limit instead of a
>  > system-wide limit.
> 
>  Actually, there is no infrastructure to account for per-UID limits right now AFAICS 
>  (please someone correct me) at ALL. We need to account and limit for per-user
> 
>  - pending signals
>  - message queues

The stuff in kernel/user.c may be sufficient for this.
