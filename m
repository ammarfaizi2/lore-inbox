Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265115AbUF2PRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUF2PRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 11:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUF2PRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 11:17:20 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:14084 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265115AbUF2PRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 11:17:19 -0400
Subject: Re: Linux scheduler (scheduling)  questions
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'andrebalsa@altern.org'" <andrebalsa@altern.org>,
       "'Richard E. Gooch'" <rgooch@atnf.csiro.au>,
       "'Ingo Molnar'" <mingo@elte.hu>, "'rml@tech9.net'" <rml@tech9.net>,
       "'akpm@osdl.org'" <akpm@osdl.org>
In-Reply-To: <313680C9A886D511A06000204840E1CF08F42FA3@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF08F42FA3@whq-msgusr-02.pit.comms.marconi.com>
Content-Type: text/plain
Date: Tue, 29 Jun 2004 17:17:13 +0200
Message-Id: <1088522233.1709.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 08:51 -0400, Povolotsky, Alexander wrote:

> 5. Deviating from the scheduling line of questions (but staying with threads
> issues): is there an option in clone(2)  to make threads 
>    not to run in the same  address space but rather act as independent
> process(es).

If you want something in a different address space, then you want a
process. Threads of the same process share the whole address space
(except they have their own stack) and this have some advantages, like
faster CPU context switching between threads of the same process, and
faster creation times, among others.


