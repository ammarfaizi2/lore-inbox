Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263902AbTCVUh2>; Sat, 22 Mar 2003 15:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263905AbTCVUh2>; Sat, 22 Mar 2003 15:37:28 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:2030 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S263902AbTCVUh0>;
	Sat, 22 Mar 2003 15:37:26 -0500
From: wind@cocodriloo.com
Date: Sat, 22 Mar 2003 22:05:35 +0100
To: Doug McNaught <doug@mcnaught.org>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 has O_SYNC bug ?
Message-ID: <20030322210535.GD891@wind.cocodriloo.com>
References: <20030322154810.A2069@verdi.et.tudelft.nl> <m37kar42ge.fsf@varsoon.wireboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m37kar42ge.fsf@varsoon.wireboard.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 02:37:53PM -0500, Doug McNaught wrote:
> Rob van Nieuwkerk <robn@verdi.et.tudelft.nl> writes:
> 
> > But the strange thing is this:  always after 30s the kernel performs
> > extra writes to the CF.  It seems it's flushing some kind of dirty buffer
> > from the buffer cache.  But there is not supposed to be any dirty buffer:
> > all data should have been written already to the CF because the partition
> > was opened with O_SYNC !
> 
> noatime?
> 
> -Doug

As he stated he was using no filesystem, but a treating the partition as
a raw file, I suppose it can't be atime-refreshing... perhaps using
O_DIRECT will solve it?

Greets, Antonio.

[sorry for double response Doug, I forgot to reply to list earlier]

