Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288850AbSAUWrQ>; Mon, 21 Jan 2002 17:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288842AbSAUWrE>; Mon, 21 Jan 2002 17:47:04 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:17808 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S288827AbSAUWqn>; Mon, 21 Jan 2002 17:46:43 -0500
Message-ID: <3C4C9BD1.61ABC1FE@nortelnetworks.com>
Date: Mon, 21 Jan 2002 17:53:05 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <200201212218.g0LMI8BQ002150@tigger.cs.uni-dortmund.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Robert Love <rml@tech9.net> said:
> 
> [...]
> 
> > It doesn't have to run mostly in the kernel.  It just has to be in the
> > kernel when the I/O-bound tasks awakes.  Further, there are plenty of
> > what we consider CPU-bound tasks that are interactive and/or
> > graphics-oriented and this adds much to their time in the kernel.
> 
> Look, I don't know about you, but system (kernel) tieme around here is
> rarely very high as a %. Perhaps 5% could be called "typical". And it is
> during those 5% (i.e., something like 5% of the time) any of this stuff
> will make a difference at all. This will be _hard_ to "feel" (if it is
> possible to feel at all).

As a thought experiment...

1) top usually averages over 5 seconds
2) 5% of 5 seconds is 0.25 seconds


What I'm getting at is that it is possible that there are cases where we could
be taking significant amounts of time to respond to something, without the
overall average being too high.

If we have even a single 0.1 second delay, that's going to be noticeable to the
user without seriously bumping up system percentages.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
