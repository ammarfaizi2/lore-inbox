Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272799AbTG3Hkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272802AbTG3Hku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:40:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51884 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272799AbTG3Hkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:40:49 -0400
Date: Wed, 30 Jul 2003 09:40:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, <linas@austin.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030730073458.GA23835@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0307300934530.433-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jul 2003, Andrea Arcangeli wrote:

> [...] I'd feel much safer with the whole timer API being smp safe w/o
> requiring driver developers to add complicated external brainer locking.
> This will provide a much more friendly abstraction.

i agree with the goal, but your patch does not achieve this. Your patch
does not make double-add_timer() safe for example. As far as i can see
your 2.6 patch only introduces additional overhead.

	Ingo

