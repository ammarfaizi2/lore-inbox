Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289627AbSAJTdJ>; Thu, 10 Jan 2002 14:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289624AbSAJTdC>; Thu, 10 Jan 2002 14:33:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17823 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289652AbSAJT0w>;
	Thu, 10 Jan 2002 14:26:52 -0500
Message-ID: <3C3DDEA9.E8FAB8DC@nortelnetworks.com>
Date: Thu, 10 Jan 2002 13:34:17 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16OUu0-00035o-00@the-village.bc.nu> <200201101753.g0AHrlA17591@snark.thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> And a sound card with only 1mS of buffer in it is definitely not useable on
> windoze, the minimum buffer in the cheapest $12 PCI sound card I've seen is
> about 1/4 second (250ms).  (Is this what you mean by "hardware fun"?)  Even
> if the app was taking half that, it's still a > 100ms big gap where the OS
> leaves it hanging before you get a dropout.  (Okay, some of that's watermark
> policy, not sending more data to the card until half the buffer is
> exhausted...)  What sound output device DOESN'T have this much cache?

Imagine taking an input, doing dsp-type calculations on it, and sending it back
as output.  Now...imagine doing it in realtime with the output being fed back to
a monitor speaker.  Think about what would happen if the output of the monitor
speaker is 1/4 second behind the input at the mike.  Now do you see the
problem?  A few ms of delay might be okay.  A few hundred ms definately is not.

> Now VIDEO is a slightly more interesting problem.  (Or synchronizing audio
> and video by sending really tiny chunks of audio.)  There's no hardware
> buffer there to cover our latency sins.  Then again, dropping frames is
> considered normal in the video world, isn't it? :)

If I'm trying to watch a DVD on my computer, and assuming my CPU is powerful
enough to decode in realtime, then I want the DVD player to take
priority--dropping frames just because I'm starting up netscape is not
acceptable.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
