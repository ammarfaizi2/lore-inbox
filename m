Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293410AbSBYOGh>; Mon, 25 Feb 2002 09:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293412AbSBYOG1>; Mon, 25 Feb 2002 09:06:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56078 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293410AbSBYOGO>; Mon, 25 Feb 2002 09:06:14 -0500
Subject: Re: [PATCH] 2.4.18-rc2 Fix for get_pid hang
To: plars@austin.ibm.com (Paul Larson)
Date: Mon, 25 Feb 2002 14:20:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosati),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <1014644491.18245.471.camel@plars.austin.ibm.com> from "Paul Larson" at Feb 25, 2002 07:41:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fLzi-00051C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > to less than the number of pids available. You seem to be fixing a non
> > problem by adding branches to the innards of a loop.
> > 
> That was my original thought, but as Rik and WLI already pointed out, it
> won't account for process groups, tgids, etc.  This isn't a purely
> theoretical problem either, as we have run up against it many times.

Agreed - and I don't have any better solutions except 32bit pid_t - which
I suspect one day we are going to need. At least the O(1) scheduler now
makes it feasible 8)
