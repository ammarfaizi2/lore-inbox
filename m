Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270862AbRHSWsx>; Sun, 19 Aug 2001 18:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270866AbRHSWsn>; Sun, 19 Aug 2001 18:48:43 -0400
Received: from [65.10.228.207] ([65.10.228.207]:13042 "HELO whatever.local")
	by vger.kernel.org with SMTP id <S270862AbRHSWsc>;
	Sun, 19 Aug 2001 18:48:32 -0400
From: chuckw@ieee.org
Date: Sun, 19 Aug 2001 06:57:02 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Looking for comments on Bottom-Half/Tasklet/SoftIRQ
Message-ID: <20010819065702.C2388@ieee.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010818231704.A2388@ieee.org> <3B7FF06A.4090606@fugmann.dhs.org> <20010819013508.B2388@ieee.org> <3B800CF9.9000606@fugmann.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B800CF9.9000606@fugmann.dhs.org>; from afu@fugmann.dhs.org on Sun, Aug 19, 2001 at 09:01:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks once again.

Chuck

On Sun, Aug 19, 2001 at 09:01:13PM +0200, Anders Peter Fugmann wrote:
> chuckw@ieee.org wrote:
> > Thanks
> > 
> > 	So, Bottom halves don't need to be re-entrant as do tasklets.  SoftIRQ's
> > need to be re-entrant.  The advantage of tasklets is that each tasklet can
> > be farmed out to different CPU's AND they don't need to be re-entrant 
> > because only one instance is allowed at a time.  I think I got it.
> 
> That is 100% correct.
> 
> > 
> > 	Could you direct me to some code in the kernel which uses tasklets
> > so I can see the inner workings?
> 
> Actually very few systems in the kernel has been rewritten to use 
> tasklets instead og BH's.
> 
> But as they are very simillar to BH's, you should be able to use the 
> same thinking, its just a new API.
> 
> Take a look at include/linux/interrupt.h
> (or http://lxr.linux.no/source/include/linux/interrupt.h, an invaluable 
> source when coding for linux).
> 
> Regards
> Anders Fugmann
> 
