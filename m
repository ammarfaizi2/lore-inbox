Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271753AbTG2Npf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271754AbTG2Npf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:45:35 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:17676 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271753AbTG2Npd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:45:33 -0400
Message-ID: <3F267CF9.40500@techsource.com>
Date: Tue, 29 Jul 2003 09:56:09 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Andrew Morton <akpm@osdl.org>, ed.sweetman@wmich.edu,
       eugene.teo@eugeneteo.net, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271046.30318.phillips@arcor.de> <20030726113522.447578d8.akpm@osdl.org> <200307271517.55549.phillips@arcor.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a couple of questions about the interactive scheduling.


First, since we're dealing with real-time and audio issues, is there any 
way we can do this:  When the interrupt arrives from the sound card so 
that the driver needs to set up DMA for the next block or whatever it 
does, move any processes which talk to an audio device to the head of 
the process queue?  Can this idea be applied to other things, such as 
moving X to the head of the queue when the DRI driver gets a "there is 
free space in the command queue" interrupt from the graphics engine?


Second, we're dealing with lots of different CPUs here, and so results 
are going to vary.  Is this being taken into account?  For any given 
interactive load, different systems will be able to carry that load only 
to the point where one has a CPU slow enough that it can't complete all 
interactive processing in the desired time.  I don't think we should be 
making scheduler tweaks to fix this corner case because it's impossible 
to fix, no?


