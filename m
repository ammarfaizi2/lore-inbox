Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270142AbTGaP0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272538AbTGaPZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:25:10 -0400
Received: from mail1.kontent.de ([81.88.34.36]:49300 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S272532AbTGaPYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:24:23 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jamie Lokier <jamie@shareable.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] O10int for interactivity
Date: Thu, 31 Jul 2003 17:24:12 +0200
User-Agent: KMail/1.5.1
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Johoho <johoho@hojo-net.de>, wodecki@gmx.de, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <200307280112.16043.kernel@kolivas.org> <200307311743.17370.kernel@kolivas.org> <20030731145937.GD6410@mail.jlokier.co.uk>
In-Reply-To: <20030731145937.GD6410@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307311724.12738.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This part interests me. It would seem that either 
> > 1. The AS scheduler should not bother waiting at all if the process is not 
> > going to wake up in that time
> 
> How about something as simple as: if process sleeps, and AS scheduler
> is waiting since last request from that process, AS scheduler stops
> waiting immediately?
> 
> In other words, a hook in the process scheduler when a process goes to
> sleep, to tell the AS scheduler to stop waiting.
> 
> Although this would not always be optimal, for many cases the point of
> AS is that the process is continuing to run, not sleeping, and will
> issue another request shortly.

How do you tell which task dirtied the page?
Wouldn't giving a bonus to tasks doing file io achieve the same purpose?
Also, isn't quickly waking up tasks more important?

	Regards
		Oliver

