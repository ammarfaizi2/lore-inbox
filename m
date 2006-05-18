Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWERLQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWERLQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWERLQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:16:04 -0400
Received: from smtp2.int-evry.fr ([157.159.10.45]:19912 "EHLO
	smtp2.int-evry.fr") by vger.kernel.org with ESMTP id S1750721AbWERLQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:16:02 -0400
Message-ID: <446C5780.7050608@int-evry.fr>
Date: Thu, 18 May 2006 13:16:16 +0200
From: Florent Thiery <Florent.Thiery@int-evry.fr>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Harald Welte <laforge@gnumonks.org>
Cc: openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org>
In-Reply-To: <20060518070700.GT17897@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-INT-MailScanner-Information: Please contact the ISP for more information
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-MailScanner-From: florent.thiery@int-evry.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  As of now, I return
>    X_ABS, Y_ABS and PRESSURE values between 0 and 1000 (each).
>
>   
Are you kidding ??? Does the touchscreen support pressure sensitivity? 
Normally it wouldn't, you'd have only two values... Because sensitivity 
touchscreens really are rare... That's why wacom does use the pen to 
report pressure info on their tablets
> 1) where does touchscreen calibration happen?  The EZX phones (like many
>    other devices, I believe) only contain resistive touchscreens that
>    appear pretty uncalibrated.   I'm sure the factory-set calibration
>    data must be stored somewhere in flash, but it's definitely handled
>    in the proprietary EZX userland, since their old kernel driver
>    doesn't have any calibration related bits.
>   
I would say touchscreen calibration = scaling (to resolution) + 
reference points
> 2) what about the 'button' event.  In addition to the pressure (which is
>    about 300 for regular stylus use, > 400 if you press hard and > 600 if
>    you use yourfinger), some existing TS drivers return a button press.
>    Is it up to me to decide after which pressure level to consider the
>    button to be pressed / released?
>   
I would say the best would be to watch pressure evolution.... If it 
springs from 0 to 400 in less than sotg like 200 ms, then you got the 
"button" event. Is it feasable?

I got a question: does stylus usage on original A780 show the pressure 
sensitivity?

Another one: you say you're workin on building X-e. Are you talking 
about kdrive?


Regards,

Florent
