Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281284AbRKMAe3>; Mon, 12 Nov 2001 19:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281297AbRKMAeT>; Mon, 12 Nov 2001 19:34:19 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:12804 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281284AbRKMAeK>;
	Mon, 12 Nov 2001 19:34:10 -0500
Message-Id: <5.1.0.14.0.20011113112416.00a1e570@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 13 Nov 2001 11:34:05 +1100
To: Linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: mysterious power off problem 2.4.10-2.4.14 on laptop
Cc: L A Walsh <law@sgi.com>
In-Reply-To: <3BF039D9.D75809F2@sgi.com>
In-Reply-To: <Pine.LNX.4.33.0111122227140.24454-100000@morpheus.streamgroup.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:06 PM 12/11/01 -0800, L A Walsh wrote:
>don't know if I am comfortable moving to it yet -- and even so, why should
>APM mysteriously break when it has been working great since the early
>2.4 series and fairly well since 2.2 (X was a problem on my hardware at one
>point).
>
>         I'd prefer not to try an unknown, where if I have a problem, I
>don't know if it is my hardware, a misconfiguration on my part, or the
>Experimental Hardware.  That would likely take more time than simply
>staying with APM -- a known 'working configuration', and finding what
>changed in 2.4.10 (and remains in 2.4.14) that lead to the new problems.

There was mention recently about some changes to APM to fix some "broken" 
behavior regarding the way it set/reset values. Some of these were cases 
where APM seemed to blindly set values instead of leaving them as is. I 
don't remember just how long ago, but you might try looking over the archives.

If this is the case, then it's possible that the APM code was checking 
status, and then blindly setting things to suit that status instead of what 
was read. Makes sense, but potentially broken. If the BIOS is broken and 
doesn't set these values correctly, then this could produce the symptoms 
you describe. Check for a BIOS upgrade anyway - usually a good manufacturer 
will have some sort of changelog with the BIOS, so if there is a new 
version, you might find APM was broken and fixed.

It's also possible that this never made it into those kernels, and they've 
been using the broken behavior since 2.4.10 which is causing your problems. 
I'd also suggest checking out the latest of the 2.4.14pre* kernels. My 
memory of the list (I may be wrong) makes me think the discussion was quite 
recent.

Good luck.

AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

