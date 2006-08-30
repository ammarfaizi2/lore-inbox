Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWH3QNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWH3QNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWH3QNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:13:48 -0400
Received: from sperry-01.control.lth.se ([130.235.83.188]:59575 "EHLO
	sperry-01.control.lth.se") by vger.kernel.org with ESMTP
	id S1750832AbWH3QNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:13:48 -0400
Message-ID: <44F5B91C.1060209@control.lth.se>
Date: Wed, 30 Aug 2006 18:13:16 +0200
From: Martin Ohlin <martin.ohlin@control.lth.se>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: A nice CPU resource controller
References: <44F5AB45.8030109@control.lth.se> <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
In-Reply-To: <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

> The CKRM e-series is a PID based CPU Controller. It did a good job of
> controlling and smoothing out the load (and variations) and even
> worked with groups. But it achieved all this through some amount of
> complexity. How do you plan to extend the idea to groups? Do you have
> any code that we can look at?

I would say that my controller so far is very simple, probably too 
simple. I have no detailed plan yet about how to incorporate groups of 
tasks, only small ideas that I would like to think a little more on 
before I say something embarrasing. The important code-parts are in the 
thesis, and I must say that the code is in no way finished, but most of 
it can be found at:
http://www.control.lth.se/user/martin.ohlin/linux/sampler.c

> I do not understand controlling the nice value? Most cpu control the
> bandwidth/time - are there any advantages to controlling the nice
> value? How does this interplay with dynamic priorities that the
> scheduler currently maintains?

There is a relationship between the nice value and the achieved 
bandwidth/time. Therefore it was possible that the nice value could be 
used to control the bandwidth/time. I wanted to know if it was possible 
to use it, and it was. As to the dynamic priorities, I do not change 
them, but as I do change the nice value and the dynamic priorities are 
relative to that, then you may say that I do change them... Anyway, it 
seems to work.

/Martin
