Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbTEAGBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 02:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTEAGBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 02:01:52 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:9195 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S262528AbTEAGBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 02:01:51 -0400
Message-ID: <3EB0BB32.1070500@wmich.edu>
Date: Thu, 01 May 2003 02:14:10 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030318
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, rmoser <mlmoser@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel source tree splitting
References: <200304301946130000.01139CC8@smtp.comcast.net> <20030430172102.69e13ce9.rddunlap@osdl.org> <9930000.1051762204@[10.10.2.4]>
In-Reply-To: <9930000.1051762204@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>I'm probably misreading this...but,
>>
>>Have you tried this yet?  Does it modify/customize all Kconfig
>>and Makefiles for the selected tree splits?
>>
>>A few days ago, in one tree, I rm-ed arch/{all that I don't need}
>>and drivers/{all that I don't need}.
>>After that I couldn't run "make *config" because it wants all of
>>those files, even if I don't want them.
>>
>>So there are many edits that needed to be done in lots of
>>Kconfig and Makefiles if one selectively pulls or omits certain
>>sub-directories.
> 
> 
> Indeed, I ran across the same thing a while back. Would be *really* nice to
> fix, if only so some poor sod over a modem can download a smaller tarball,
> or save some diskspace.
> 
> M.
> 

Tried doing this a while ago with my own cvs server. I'd download the 
tarball untar it into the cvs dump. I made a modules file tha that 
described all kinds of possible modules and then modules that utilized 
those and so on until you could just do co -z9 linux-i386 to get a all 
the files required to make any i386 linux ...it was mostly to just 
separate the archs, not unneeded drivers. Of course i quickly ran into 
the make not working without all the other files from the other archs 
and i came to the conclusion you couldn't do this without editing 
certain build scripts and files (and since I didn't want the files to be 
altered in case people would eventually want to call security into 
question) i killed the whole idea.

This idea comes and goes like many others.  As far as modular 
programming goes the kernel isn't written to be very modular, either 
that or it is and the build system just looks over that fact.  It would 
be interesting to see how hard it would be to have the current config to 
not only generate its .config but also a list of commands that an 
autoconf created ./configure can read and use to generate the makefiles 
we then use to build the kernel.  it could also help in enforcing 
minimum versions instead of hoping the user does it before complaining 
to people who could be doing better things with their time.  Anyways, 
i'm sure this idea has been coined and dropped before as well.  So it's 
back to the way things are done like normal.

