Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSKVFeY>; Fri, 22 Nov 2002 00:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKVFeY>; Fri, 22 Nov 2002 00:34:24 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:59589 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S265074AbSKVFeX>; Fri, 22 Nov 2002 00:34:23 -0500
Message-ID: <3DDDC37F.5AC219D5@attbi.com>
Date: Fri, 22 Nov 2002 00:41:19 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: efault@gmx.de, linux-kernel@vger.kernel.org
CC: riel@conectiva.com.br
Subject: Re: 2.5.47 scheduler problems?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike, Rik, Everyone,

The O(1) schedule just isn't fair.  It will run a subset 
of the runable processes excluding the rest.  See my earlier
emails for the details.

I had been working on a fix for this but got distracted
by Posix timers.  I still hope to get back to it.

My patch is here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103508412423719&w=2

It fixes fairness but breaks nice(2). Rik van Riel has a
patch here which builds on my patch which fixes this:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103651801424031&w=2

I just gave this a spin with.  The patches still apply cleanly
to linux-2.5.48 and it seems well behaved:-)  

I found this problem with the LTP waitpid06 test.  It actually
produced a live-lock. See this mail:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103133744217082&w=2

Jim Houston - Concurrent Computer Corp.
