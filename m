Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264974AbSKESNY>; Tue, 5 Nov 2002 13:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264988AbSKESMK>; Tue, 5 Nov 2002 13:12:10 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:34546 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264974AbSKESMD>; Tue, 5 Nov 2002 13:12:03 -0500
Date: Tue, 5 Nov 2002 13:18:39 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: John Gardiner Myers <jgmyers@netscape.com>
Cc: linux-aio@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: pipe POLLOUT oddity
Message-ID: <20021105131839.B3934@redhat.com>
References: <20021031230215.GA29671@bjl1.asuk.net> <Pine.LNX.4.44.0210311642300.1562-100000@blue1.dev.mcafeelabs.com> <20021101020119.GC30865@bjl1.asuk.net> <3DC30DED.6040207@netscape.com> <20021102045535.GA21356@mark.mielke.cc> <20021031230215.GA29671@bjl1.asuk.net> <3DC80AC5.6080705@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC80AC5.6080705@netscape.com>; from jgmyers@netscape.com on Tue, Nov 05, 2002 at 10:15:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 10:15:33AM -0800, John Gardiner Myers wrote:
> I could see this going either way, depending on the application. 
>  Holding off the POLLOUT readiness could improve performance by making 
> sure that whenever a process is scheduled to write to a pipe the pipe 
> has enough buffer to take all of the data.

Aio write to pipes has a distinct advantage here as the pipe code can 
provide the write atomicity guarantees while preserving the non-blocking 
aspect of the io submission interface.

		-ben
-- 
"Do you seek knowledge in time travel?"
