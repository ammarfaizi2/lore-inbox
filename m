Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317999AbSGaMaa>; Wed, 31 Jul 2002 08:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318006AbSGaMaa>; Wed, 31 Jul 2002 08:30:30 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:57092 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317999AbSGaMaa>; Wed, 31 Jul 2002 08:30:30 -0400
Date: Wed, 31 Jul 2002 09:33:34 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Diego Calleja <diegocg@teleline.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: profile of 2.4.19-rc3-ac4
In-Reply-To: <20020731020530.35cb7fc5.diegocg@teleline.es>
Message-ID: <Pine.LNX.4.44L.0207310932150.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002, Diego Calleja wrote:

> This is the profile of a 2.4.19-rc3-ac4 after a heavy disk /swap usage.
> I send it because it seems that page_referenced takes a lot of time....

That might well be because it's being called a LOT, since in
a disk/swap intensive workload we want to make very sure we
evict the right page from RAM.

A disk seek is worth about ten million CPU cycles...

> 607951 default_idle                             15198,7750
>   1019 page_referenced                           16,9833
>    831 serial_in                                 15,9808
>    406 __rdtsc_delay                             14,5000
>    836 unlock_page                                6,3333


Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

