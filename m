Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRJJCFR>; Tue, 9 Oct 2001 22:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRJJCE7>; Tue, 9 Oct 2001 22:04:59 -0400
Received: from cx739861-a.dt1.sdca.home.com ([24.5.164.61]:54535 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S273854AbRJJCEi>; Tue, 9 Oct 2001 22:04:38 -0400
Date: Tue, 9 Oct 2001 19:04:49 -0700
To: Robert Love <rml@tech9.net>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org,
        kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH *] faster cache reclaim
Message-ID: <20011009190449.A25261@gnuppy>
In-Reply-To: <Pine.LNX.4.33L.0110082032070.26495-100000@duckman.distro.conectiva> <1002670160.862.15.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002670160.862.15.camel@phantasy>
User-Agent: Mutt/1.3.22i
From: Bill Huey <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 07:29:13PM -0400, Robert Love wrote:
> For example, starting a `dbench 16' would sometimes cause a brief stall
> (especially if it is the second run of dbench).  It's better now, but
> still not perfect.  The VM holds a lot of locks for a long time.
> 
> Good work.  I hope Alan sees it soon.

Yeah, but overall the performance of his recent patch is pretty amazing.

It's really good that Linux is finally getting a VM that behaves well and
can keep the working set in memory without heavy IO activity flushing out
critical process pages. The performance of Riel's VM system should hold for
server activity too. And adding something like thrash control to help make
sure aging still works (without statistical scattering) under heavy load
should allow Riel's VM to progress under loads that would freeze previous VMs.

;-)

bill

