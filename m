Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSIYTAA>; Wed, 25 Sep 2002 15:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbSIYS77>; Wed, 25 Sep 2002 14:59:59 -0400
Received: from mail.webmaster.com ([216.152.64.131]:34721 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S262060AbSIYS76> convert rfc822-to-8bit; Wed, 25 Sep 2002 14:59:58 -0400
From: David Schwartz <davids@webmaster.com>
To: <pwaechtler@mac.com>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1055) - Licensed Version
Date: Wed, 25 Sep 2002 12:05:12 -0700
In-Reply-To: <B9100B20-D013-11D6-8873-00039387C942@mac.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020925190513.AAA11056@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>With Scheduler Activations this could also be avoided.
>The thread scheduler could get an upcall - but this will stay theory for
>a long
>time on Linux.
>But this is a somewhat far fetched example (for arguing for 1:1), isn't
>it?

	No, it's not. I write high-performance servers and my main enemy is 
burstiness. One significant cause of burstiness is code faulting in. This is 
especially true because many of my servers support adding code to them 
through user-supplies shared object files.

>There are other means of DoS..

	I'm not talking about deliberate attempts at harming the server. These won't 
work over and over because the code will fault in once and be in. I'm talking 
about smooth performance in the face of unpredictable loads, and that means 
not stalling on every page fault.

	DS


