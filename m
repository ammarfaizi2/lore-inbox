Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293407AbSBYNxp>; Mon, 25 Feb 2002 08:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293388AbSBYNxg>; Mon, 25 Feb 2002 08:53:36 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27838 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293407AbSBYNxT>;
	Mon, 25 Feb 2002 08:53:19 -0500
Subject: Re: [PATCH] 2.4.18-rc2 Fix for get_pid hang
From: Paul Larson <plars@austin.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosati <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E16eQ4R-0003cZ-00@the-village.bc.nu>
In-Reply-To: <E16eQ4R-0003cZ-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 Feb 2002 07:41:30 -0600
Message-Id: <1014644491.18245.471.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-22 at 18:29, Alan Cox wrote:
> > This was made against 2.4.18-rc2 but applies cleanly against
> > 2.4.18-rc4.  This is a fix for a problem where if we run out of
> > available pids, get_pid will hang the system while it searches through
> > the tasks for an available pid forever.
> 
> Wouldn't it be a much cleaner patch to limit the maximum number of processes
> to less than the number of pids available. You seem to be fixing a non
> problem by adding branches to the innards of a loop.
> 
That was my original thought, but as Rik and WLI already pointed out, it
won't account for process groups, tgids, etc.  This isn't a purely
theoretical problem either, as we have run up against it many times.

Thanks,
Paul Larson

