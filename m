Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272508AbSISU1Y>; Thu, 19 Sep 2002 16:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272935AbSISU1Y>; Thu, 19 Sep 2002 16:27:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29702 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272508AbSISU1Y>; Thu, 19 Sep 2002 16:27:24 -0400
Date: Thu, 19 Sep 2002 13:32:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <8XBysGvmw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.44.0209191324310.1277-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19 Sep 2002, Kai Henningsen wrote:
> 
> On the contrary: it says that this can never happen - the new session has  
> no controlling terminal, and can't get the old one unless the old session  
> loses it first.

Hmm.. I read it as "the tty stays with the stale group", which is
problematic. But if all the places that set a new controlling terminal
check that it's not already used by some other non-session then I guess 
we're still ok..

		Linus

