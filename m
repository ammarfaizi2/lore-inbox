Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbUAFXs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUAFXs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:48:27 -0500
Received: from cibs9.sns.it ([192.167.206.29]:57861 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S265849AbUAFXs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:48:26 -0500
Date: Wed, 7 Jan 2004 00:48:14 +0100 (CET)
From: venom@sns.it
To: Hans Reiser <reiser@namesys.com>
cc: Steve Glines <sglines@is-cs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: file system technical comparisons
In-Reply-To: <3FFAA4F6.5040501@namesys.com>
Message-ID: <Pine.LNX.4.43.0401070036190.19759-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Hans Reiser wrote:

> balanced trees squish things together at every modification of the
> tree.  Dancing trees squish things together when they get low on ram,
> which is less often.  this means that we can afford to squish tighter
> because we do it less often.

This is generally true except some maior cases.

A SAP server, for example, is "always" low on ram, not because of oracle, but
because how the "disp+work" processes work.

Another case I am thinking is a tibco server, when processes start to fork
because of a lot of incoming messages from everywhere, and the DB really start
to write a lot of stuff (all small writes).

I am curious to make some test in those cases.

Another think I am thinking about is an MC^2 lun. If all the I/O is resolved
inside of the EMC cache, BTrees could be better than dancing trees? In fact
in this case what matters is the CPU power you are using, since you de facto
talk just with EMC cache.

I know those are strange scenarios, but those are the scenarios I am actually
working with. Since those are not typical situations, I think right now they are
ininfluent, but in the future maybe more people will have to deal with them.

Anyway untill I do not make some serious experiment mine are just
speculations.

Luigi

