Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbSJJMXb>; Thu, 10 Oct 2002 08:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSJJMXb>; Thu, 10 Oct 2002 08:23:31 -0400
Received: from AGrenoble-101-1-2-94.abo.wanadoo.fr ([193.253.227.94]:16525
	"EHLO awak") by vger.kernel.org with ESMTP id <S262310AbSJJMXa> convert rfc822-to-8bit;
	Thu, 10 Oct 2002 08:23:30 -0400
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
From: Xavier Bestel <xavier.bestel@free.fr>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DA55E0C.24033BB5@aitel.hist.no>
References: <XFMail.20021010113849.pochini@shiny.it> 
	<3DA55E0C.24033BB5@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Oct 2002 14:29:11 +0200
Message-Id: <1034252951.961.23.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 10/10/2002 à 13:01, Helge Hafting a écrit :
> Giuliano Pochini wrote:
> 
> > Yes, it makes sense, but it's useless or harmful to discard caches
> > if nobody else needs memory. You just lose data that may be
> > requested in the future for no reason.
> 
> Sure, so the ideal is to not drop unconditionally, but
> make sure that the "finished" O_STREAMING pages are
> the very first ones to go whenever memory pressure happens.

IMHO this shoudln't be taken care of. As you say it, a linux box has no
free memory (or it's been very recently booted), so the problem is not
to make O_STREAMING pages "low priority", but just to make them not stay
in the cache (perhaps just keep a few KB worth of them in case of a
limited seek back, but not more).

	Xav

