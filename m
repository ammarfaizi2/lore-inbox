Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279950AbRKDIk1>; Sun, 4 Nov 2001 03:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279978AbRKDIkR>; Sun, 4 Nov 2001 03:40:17 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:23047 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S279950AbRKDIkC>;
	Sun, 4 Nov 2001 03:40:02 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111040839.fA48deO123804@saturn.cs.uml.edu>
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
To: mark@alpha.dyndns.org (Mark McClelland)
Date: Sun, 4 Nov 2001 03:39:40 -0500 (EST)
Cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org, volodya@mindspring.com
In-Reply-To: <3BDE9251.3010901@alpha.dyndns.org> from "Mark McClelland" at Oct 30, 2001 03:43:13 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark McClelland writes:
> volodya@mindspring.com wrote:
>> On Mon, 29 Oct 2001, Gerd Knorr wrote:

>>> You can't.  But I don't see why this is a issue:  The only thing a
>>> application can handle easily are controls like contrast/hue where the
>>> only thing a application needs to do is to map it to a GUI and let the
>>> user understand and adjust stuff.  The other stuff has way to much
>>> non-trivial dependences, I doubt a application can blindly use new
>>> driver features.
>>
>> Have you ever thought that the reason we only use these controls is
>> because they are the only ones easy to implement now ?
>
> What I don't understand is how will your driver implement these controls 
> in a generic V4L3  GUI control app automatically? No matter how powerful 
> the semantic information you give to the app is, it can still only build 
> interfaces from standard GUI components that it already knows about. The 
> app cannot build a gamma curve control on its own. If it could, we 
> wouldn't need programmers anymore :)

The driver provides this:  /proc/v4l3/vid0/gamma.java

:-)

The very idea of a gamma table is featuritis. Just a single number
will do for most anyone. You get from 0.01 to 2.55 and "off" with
just 8 bits.

If you want to get fancy, I guess you need:

1 gamma value per primary
3 tri-stimulus values for each primary  ("What color is red?")
3 tri-stimulus values for the whitepoint (maybe)
1 black level for each primary

That is 18 values at most.


