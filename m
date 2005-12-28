Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVL1ROE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVL1ROE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVL1ROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:14:04 -0500
Received: from kirby.webscope.com ([204.141.84.57]:39830 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932544AbVL1ROD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:14:03 -0500
Message-ID: <43B2C7AC.2070603@gmail.com>
Date: Wed, 28 Dec 2005 12:13:16 -0500
From: Michael Krufky <mkrufky@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
CC: Mark Knecht <markknecht@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       markus.kossmann@inka.de, Mauro Carvalho Chehab <mchehab@infradead.org>,
       Michael Krufky <mkrufky@m1k.net>, linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: Ho ho ho.. Linux 2.6.15-rc7
References: <43B2B913.9090002@laPoste.net>
In-Reply-To: <43B2B913.9090002@laPoste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:

>1. the latest and greatest ivtv is 0.5.x svn trunk
>2. a week ago it still depended on some v4l cvs changes not merged
>upstream (ie could not build without a private v4l tree dump)
>3. and it had firmware loading problems with the latest 2.6.15-rc git
>dumps
>4. the merging process stalled considerably when the paken fork was
>discovered
>
>The root of the problem of course is ivtv developpers still haven't
>understood the "release early, release often" part and are aiming for
>a perfect (cleaned-up and feature-complete) driver before submitting
>it. Instead of merging everything now (experimental) and finishing the
>paken merge cleanup / inside the kernel.
>
>ivtv 0.5 is not even available as a kernel patchset, so you get the
>idea. ivtv writers would get a boatload of feedback if it behaved like
>any other kernel patchset.
>
>Now don't get me wrong, the ivtv people did and are doing a wonderful
>job driver-side, but they seriously need to learn to integrate in the
>kernel ecosystem. Someone wrote in the thread about the need to "kick"
>them a bit to make them understand this. I'm afraid this feeling is
>shared by a lot of other people. The low priority given to merging is
>real frustrating.
>  
>
Please, give them a break, and let's end this conversation right now.  
IVTV has come a long way in a path of merging into V4L, especially 
during 2.6.15 development.  This is not simply a matter of getting the 
ivtv code into the kernel to let it compile correctly.... This is also 
an issue of changing the ivtv modules to conform with the V4L2 API, and 
to make all of these modules behave in the same style as the other v4l 
kernel modules, so that other devices can use the ivtv modules, etc.

We are trying to encourage proper codingstyle, so that things are 
correct from the start...  This is not simply a matter of merging in a 
new module -- When ready, the ivtv modules will become part of the v4l 
subsystem, and card drivers will make use of them.  These modules must 
conform to a standard API as the rest of V4L does... Otherwise, we would 
be creating more work for ourselves later on.

I can go on and on explaining why there needs to be work done before 
this is all merged in... but simply enough, it isn't ready.  (although 
it seems to be getting there soon)   There are people working on it, and 
significant headway has been made in the past few months.  We want this 
to be done correctly -- not quickly for a deadline.  Remember, the 
people working on this code are doing it because they want it to work -- 
NOT because they have a deadline in order to receive a paycheck.  Please 
have some patience, and things will be better in the longrun.

About the dependency on the v4l cvs tree, this is part of the transition 
-- When the ivtv guys are finished with a module, it goes to the v4l-dvb 
cvs, where we will make additional cleanups, and set up Kconfig, etc...  
Now that there is this "upstream merge window" policy, that explains why 
there are some ivtv dependencies in v4l-dvb cvs, that are not yet in the 
kernel.  If you read the ivtv mailing list, or the web site 
instructions, you will understand that there is a 0.4.x series, for use 
as standalone, and a 0.5.x series, which depends ont the v4l-dvb tree.

I'm done rambling.... Just have patience.... Merges will happen soon 
enough.  Please dont try to rush things.

Cheers,

Michael Krufky

P.S.:  Hans, Taylor, and all the other ivtv developers - You're doing a 
great job, and keep up the good work.  This just goes to show how much 
the community appreciates the work of the ivtv project. :-D

