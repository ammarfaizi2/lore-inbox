Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280764AbRKSVxT>; Mon, 19 Nov 2001 16:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280755AbRKSVxJ>; Mon, 19 Nov 2001 16:53:09 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:30676 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280744AbRKSVw5>;
	Mon, 19 Nov 2001 16:52:57 -0500
Date: Mon, 19 Nov 2001 21:52:53 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Rik van Riel <riel@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Remco Post <r.post@sara.nl>, James A Sutherland <jas88@cam.ac.uk>,
        linux-kernel@vger.kernel.org, remco@zhadum.sara.nl,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Swap 
Message-ID: <1924931095.1006206772@[195.224.237.69]>
In-Reply-To: <Pine.LNX.4.33L.0111191917000.1491-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0111191917000.1491-100000@duckman.distro.conecti
 va>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

--On Monday, 19 November, 2001 7:17 PM -0200 Rik van Riel 
<riel@conectiva.com.br> wrote:

>> Out of interest, is received wisdom that this is a good/bad
>> thing?
>
> Load control is a good thing since it means the box
> gets slower in a controlled way instead of running
> fine one minute and horribly falling over the next
> minute.
>
> I'm certainly planning to implement some load control
> measures for 2.5.

OK another potentially dumb question on this:

I had previously (mis?)understood load control to mean (say)
clustering page out requests to pages from specific
processes, then altering the scheduler to avoid scheduling these
processes for extended periods of time, then moving onto the next
set of processes to victimize, and so forth; i.e. increasing
scheduler granularity to cope with increased average virtual
memory access times by decreasing VM footprint used per second.

The original poster seemed to be talking about the old-UNIX
definition of swapping, which, if I remember right, was releasing
/all/ clean pages for an app (I guess this has already been done
by the time we want to do this) and paging /all/ dirty pages
& freeing the memory there and then.

I'd have thought swapping was a pretty coarsely-grained
form of load control (and difficulted with shared mem etc.);
do you believe there is a requirement to implement (old UNIX)
swapping per-se, or merely to intelligently tweak the scheduler
to cope better with high VM system loads? [the absence of the
former was what I was suggesting might have been considered
a good thing]

--
Alex Bligh
