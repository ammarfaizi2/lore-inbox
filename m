Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282971AbRLCIvt>; Mon, 3 Dec 2001 03:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284368AbRLCItj>; Mon, 3 Dec 2001 03:49:39 -0500
Received: from marine.sonic.net ([208.201.224.37]:48225 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S284828AbRLCG4t>;
	Mon, 3 Dec 2001 01:56:49 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Sun, 2 Dec 2001 22:56:44 -0800
From: David Hinds <dhinds@sonic.net>
To: Ian Morgan <imorgan@webcon.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dhinds@zen.stanford.edu
Subject: Re: BUG() in spinlock.h loading ds.o
Message-ID: <20011202225644.A14160@sonic.net>
In-Reply-To: <20011201120541.B28295@sonic.net> <Pine.LNX.4.40.0112022135520.1798-100000@light.webcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0112022135520.1798-100000@light.webcon.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2001 at 10:25:56PM -0500, Ian Morgan wrote:
> 
> Well, I've tried the new 30-Nov-01 package, but ds.o still keeps causing
> oopses consistently, whether in UP or SMP. I've also turned on kernel BUG()
> reporting, which seems to indicate a problem in spinlock.h. Hare are a
> couple sample oopses:

Oh.  Hmmm.  The problem is that the PCMCIA package doesn't know about
the spinlock debugging option, so it mis-sized the spinlock data
structure.

I can modify the PCMCIA Configure script to process this option.  Of
course this doesn't address your main problem with the orinoco driver.

-- Dave
