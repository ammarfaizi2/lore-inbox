Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272623AbTHIRor (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272820AbTHIRor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:44:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11688 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272623AbTHIRo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:44:26 -0400
Date: Sat, 9 Aug 2003 10:39:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jmorris@intercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-Id: <20030809103910.7e02037b.davem@redhat.com>
In-Reply-To: <20030809140542.GR31810@waste.org>
References: <20030809074459.GQ31810@waste.org>
	<20030809010418.3b01b2eb.davem@redhat.com>
	<20030809140542.GR31810@waste.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 09:05:42 -0500
Matt Mackall <mpm@selenic.com> wrote:

> All of which is a big waste of time if the answer to "is making
> cryptoapi mandatory ok?" is no. So before embarking on the hard part,
> I thought I'd ask the hard question.

I'm personally OK with it, and in fact I talked about this with James
(converting random.c over to the crypto API and the implications)
early on while we were first working on the crypto kernel bits.

But I fear some embedded folks might bark.  Especially if the
resulting code size is significantly larger.

We could make it a config option CONFIG_RANDOM_CRYPTOAPI.

All of this analysis nearly requires a working implementation so
someone can do a code-size and performance comparison between
the two cases.  I know this is what you're trying to avoid, having
to code up what might be just thrown away :(

