Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbTCaIia>; Mon, 31 Mar 2003 03:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261479AbTCaIia>; Mon, 31 Mar 2003 03:38:30 -0500
Received: from k101-11.bas1.dbn.dublin.eircom.net ([159.134.101.11]:13324 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S261476AbTCaIi3>;
	Mon, 31 Mar 2003 03:38:29 -0500
Message-ID: <3E880020.1060607@draigBrady.com>
Date: Mon, 31 Mar 2003 09:45:20 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Mansfield <lkml@dm.cobite.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: very poor performance in 2.5.66[-mm1]
References: <Pine.LNX.4.44.0303281247480.11928-100000@admin>
In-Reply-To: <Pine.LNX.4.44.0303281247480.11928-100000@admin>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield wrote:
> Hi list.
> 
> After all of the rave reviews about the interactivity fixes (both regular 
> and I/O scheduler related), I decided to give the 2.5.latest a try on my 
> desktop machine (system described below)
> 
> I started X, everything seemed fine, maybe a bit faster.  I opened a 
> 'gnome-terminal' and typed 'ls -ltr'.  Wow, it was 20x slower.
> 
> Here are the timings for 'ls -ltr':
> 
> 2.5.66-mm1:      'ls -ltr'         31 seconds
> 2.5.66-mm1:      'ls -ltr | cat'   2 seconds
> 2.4.18-rhlatest: 'ls -ltr'         1.14 seconds

I've noticed this on all kernels and it seems scheduling related
hence why the latest triggers it for you. As far as I can see
most times writing data to gnome-terminal WHICH CAUSES IT TO SCROLL
it takes a ridiculous amount of time. If I take some CPU time away
from gnome-terminal by the official "window wiggling" method it
runs much faster. Note it's not rendering (antialiasing) related
as I turned that off with the same effect.

Pádraig.

