Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289521AbSAJQRZ>; Thu, 10 Jan 2002 11:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289520AbSAJQRQ>; Thu, 10 Jan 2002 11:17:16 -0500
Received: from [208.48.139.185] ([208.48.139.185]:21210 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S289519AbSAJQRI>; Thu, 10 Jan 2002 11:17:08 -0500
Date: Thu, 10 Jan 2002 08:17:01 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Dilger <adilger@turbolabs.com>, Bruce Guenter <bruceg@em.ca>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Where's all my memory going?
Message-ID: <20020110081701.A1205@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@turbolabs.com>,
	Bruce Guenter <bruceg@em.ca>, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com> <20020110024520.A29045@em.ca> <20020110030537.C771@lynx.adilger.int> <20020110145542.B2499@mould.bodgit-n-scarper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020110145542.B2499@mould.bodgit-n-scarper.com>; from matt@bodgit-n-scarper.com on Thu, Jan 10, 2002 at 02:55:42PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 02:55:42PM +0000, Matt Dainty wrote:
>
> Patch applied cleanly, and I redid the 'test'. I've attached the output
> of free and /proc/slabinfo, *.1 is without patch, *.2 is with. In both
> cases postal was left to run for about 35 minutes by which time it had
> delivered around ~54000 messages locally.
> 
> Overall, with the patch, the large numbers in /proc/slabinfo are *still*
> large, but not as large as without the patch. Overall memory usage still
> seems similar.

So the performance of the test was the same with or without the patch?

Does top or vmstat indicate any kind of difference on the system when the
benchmark is pushing 1500 msgs/s vs 150 msgs/s?

There's a kernel profiling tool somewhere that might also help if there's a
large amount of system time being used up.  (I think this is it:
http://oss.sgi.com/projects/kernprof/)

-Dave
