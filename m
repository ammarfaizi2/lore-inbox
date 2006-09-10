Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWIJOel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWIJOel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWIJOel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 10:34:41 -0400
Received: from homer.mvista.com ([63.81.120.158]:60668 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932206AbWIJOek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 10:34:40 -0400
Subject: Re: [PATCH 2/3] FRV: Permit __do_IRQ() to be dispensed with
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
In-Reply-To: <20060909051211.GA6922@elte.hu>
References: <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com>
	 <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com>
	 <20060909051211.GA6922@elte.hu>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 07:34:37 -0700
Message-Id: <1157898878.3516.2.camel@c-67-169-176-11.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 07:12 +0200, Ingo Molnar wrote:

> The real solution would be to use gcc -ffunction-sections plus ld 
> --gc-sections to automatically get rid of unused global functions, at 
> link time. I'm wondering how hard it would be to enhance kbuild to do 
> that - x86_64 already uses -ffunction-sections (if CONFIG_REORDER), so 
> the big question is how usable is ld --gc-sections. Such a feature would 
> be quite important for embedded systems (and for RAM footprint in 
> general) as it would save a significant amount of .text and .data.

A patch to do this was submitted already by Marcelo Tosatti ..

http://lkml.org/lkml/2006/6/4/169

Daniel

