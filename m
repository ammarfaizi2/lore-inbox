Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTFPX0l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 19:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbTFPX0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 19:26:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39927 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S264450AbTFPX0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 19:26:40 -0400
Subject: Re: Linux 2.5.71 - random console corruption
From: Robert Love <rml@tech9.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Gerhard Mack <gmack@innerfire.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306170032070.26878-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0306170032070.26878-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1055806828.7069.176.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 16 Jun 2003 16:40:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-16 at 16:34, James Simmons wrote:

> For userland<->kernel transactions we have the console_semaphore to 
> protect us. It is also used for console_callback. The console_semaphore is
> not used internally to protect global variables :-( To do this properly 
> would take quite a bit of work.  

It looks like all these globals need a lock -- they can race on SMP or
with kernel preemption.

Is it really going to be that hard to wrap a lock around their access,
because I think this is going to bite SMP users.

	Robert Love

