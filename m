Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVAJP6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVAJP6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVAJP6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:58:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60343 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262303AbVAJP57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:57:59 -0500
Date: Mon, 10 Jan 2005 09:54:42 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: piotr@larroy.com (Pedro Larroy)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/4][RFC] Genetic Algorithm Library
Message-ID: <20050110095442.40a544fd@localhost>
In-Reply-To: <20050108153757.GA5972@larroy.com>
References: <20050106100844.53a762a0@localhost>
	<20050108153757.GA5972@larroy.com>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From a quick look I've seen your algorithm tends to converge to a
> global optimum, but also as William Lee Irwin III has commentend on
> irc, it might miss "special points" since there's no warranty of the
> function to minize to be continuous.

This is a very good point, and is something that I'm working on now.  I
would like to be able to able to have multiple fitness rankings (ex. one
that ranks specifically for throughput and one specifically for
interactivity/latency).  Then tune specific genes, that actually
impact that specific fitness check.
 
> I think it's a good idea to introduce this techniques to tune the
> kernel, but perhaps userland would be the right place for them, to be
> able to switch them off when in need or have more controll over them.
> But it's a nice initiative in my opinion.

I considered doing this in userland at first, but I went away from it
for a couple reasons.  I wanted users of the library to have a lot of
flexibility.  There was also a concern with the extra overhead going
inbetween user/kernel space (important for users who's children have
very short life-spans).

Jake
