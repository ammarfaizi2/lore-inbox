Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272492AbTHPAUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 20:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272502AbTHPAUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 20:20:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:6879 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272492AbTHPAUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 20:20:17 -0400
Date: Fri, 15 Aug 2003 17:05:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: tytso@mit.edu, jmorris@intercode.com.au, jamie@shareable.org,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-Id: <20030815170532.06e14e89.akpm@osdl.org>
In-Reply-To: <20030815235501.GB325@waste.org>
References: <20030809173329.GU31810@waste.org>
	<Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au>
	<20030810174528.GZ31810@waste.org>
	<20030813032038.GA1244@think>
	<20030813040614.GP31810@waste.org>
	<20030815221211.GA4306@think>
	<20030815235501.GB325@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> I'm pretty sure there was never a time when entropy
> accounting wasn't racy let alone wrong, SMP or no (fixed in -mm, thank
> you).

Well is has been argued that the lack of locking in the random driver is a
"feature", adding a little more unpredictability.

Now I don't know if that makes sense or not, but the locking certainly has
a cost.  If it doesn't actually fix anything then that cost becomes a
waste.

IOW: what bug does that locking fix?


