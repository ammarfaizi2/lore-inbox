Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWCHCul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWCHCul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWCHCul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:50:41 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:10629 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S932339AbWCHCuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:50:40 -0500
Message-ID: <440E467D.70804@tlinx.org>
Date: Tue, 07 Mar 2006 18:50:37 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Magnus Damm <magnus.damm@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: FWIW: Re: SMP and 101% cpu max?
References: <aec7e5c30603070434j7f326ad2r5f1b0e8046870941@mail.gmail.com> <9a8748490603070507h48e2fe02qbf9da7956e794161@mail.gmail.com>
In-Reply-To: <9a8748490603070507h48e2fe02qbf9da7956e794161@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, running/compiling 2.6.15.5 on a 2x(1GHzxP-III), 1GB
times for "make" -jn bzImage (no modules):
(using export TIMEFORMAT="%2Rsec %2Uusr %2Ssys (%P%% cpu)" )

-j1: 815.80sec 745.64usr 78.74sys (100.00% cpu)
-j2: 445.17sec 778.68usr 86.22sys (100.00% cpu)
-j3: 444.89sec 781.66usr 87.84sys (100.00% cpu)
-j4: 443.08sec 781.81usr 87.97sys (100.00% cpu)
-j5: 445.98sec 782.53usr 87.51sys (100.00% cpu)
-----

I am not seeing the symptom you are describing.  The load
increases proportionately to the 'job limit', but it doesn't
radically change the overall cpu required.  As I have
only 2 cpu's, I can't expect much benefit beyond 2x, with
actual approaching closer to 1.8x.

-l


Jesper Juhl wrote:
> On 3/7/06, Magnus Damm <magnus.damm@gmail.com> wrote:
>   
>> With 128MB and 256MB configurations, a majority of the tests never
>> make it over 101% CPU usage when I run "make -j 2 bzImage", building a
>> allnoconfig kernel. With 64MB memory, everything seems to be working
>> as expected. Also, running "make bzImage" works as expected too.
>>     
> Hmm, I wonder if it's related to the problem I reported here :
> http://lkml.org/lkml/2006/2/28/219
> Where I need to run make -j 5 or higher to load both cores of my Athlon X2.
>   
