Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319007AbSIIWkR>; Mon, 9 Sep 2002 18:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319009AbSIIWkR>; Mon, 9 Sep 2002 18:40:17 -0400
Received: from midway.uchicago.edu ([128.135.12.12]:48042 "EHLO
	midway.uchicago.edu") by vger.kernel.org with ESMTP
	id <S319007AbSIIWkQ>; Mon, 9 Sep 2002 18:40:16 -0400
Date: Mon, 9 Sep 2002 17:44:10 -0500
From: Roy Bixler <rcb@ucp.uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: Compilation problems with 2.5.34 on ultrasparc
Message-ID: <20020909224410.GB8976@ucp.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My first problem was that 'SIGSTKFLT' is undefined for sparc64 but
referenced in a couple of macros in kernel/signal.c.  My temporary fix
was simply to take SIGSTKFLT out of the macro definitions.

The problem I now have is that the definition of the
'dequeue_signal()' function has apparently changed from taking 2
arguments to 3 arguments.  All of the calls in the arch/sparc64/kernel
directory use 2 argument calls.

Does anyone have a fix?

thx,

--
Roy Bixler
rcb@ucp.uchicago.edu
