Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSH0Iil>; Tue, 27 Aug 2002 04:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSH0Iil>; Tue, 27 Aug 2002 04:38:41 -0400
Received: from [62.40.73.125] ([62.40.73.125]:58257 "HELO Router")
	by vger.kernel.org with SMTP id <S315406AbSH0Iik>;
	Tue, 27 Aug 2002 04:38:40 -0400
Date: Tue, 27 Aug 2002 10:42:44 +0200
From: Jan Hudec <bulb@cimice.maxinet.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jan Hudec <bulb@vagabond.cybernet.cz>, bulb@cimice.maxinet.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Question about leases
Message-ID: <20020827084244.GA23077@vagabond>
Mail-Followup-To: Jan Hudec <bulb@cimice.maxinet.cz>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jan Hudec <bulb@vagabond.cybernet.cz>, linux-kernel@vger.kernel.org
References: <20020827010616.GB16207@vagabond> <20020827143517.40ba04f7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827143517.40ba04f7.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 02:35:17PM +1000, Stephen Rothwell wrote:
> > As far as I figured out process holding a lease is notified when other
> > process opens the leased file. But I am still not sure how the leases
> > should then be released and how the process knows which lease was broken
> > (struct siginfo does not seem to have union member for that case).
> 
> To release a lease, you use fcntl(fd, F_SETLEASE,  F_UNLCK).  The file
> descriptor of the file that the lease is on is returned in the
> siginfo structure.

One more question. Does the siginfo contain information weather is's
read or write that the other process attempted? And does it contain the
operation type for directory notifications?

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
