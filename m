Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbTKMWkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 17:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTKMWkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 17:40:55 -0500
Received: from heron.mail.pas.earthlink.net ([207.217.120.189]:6532 "EHLO
	heron.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264441AbTKMWkv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 17:40:51 -0500
From: Guy <fsos_guy@earthlink.net>
Organization: C
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6 scheduler and "fast user switching"
Date: Thu, 13 Nov 2003 16:11:46 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200311130430.06882.fsos_guy@earthlink.net> <3FB366DB.80508@cyberone.com.au>
In-Reply-To: <3FB366DB.80508@cyberone.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311131611.51951.fsos_guy@earthlink.net>
X-ELNK-Trace: d501ffacebf681585e89bb4777695beb702e37df12b9c9efe1ace5b41f285a82f84cda661d8bc317350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 November 2003 06:11, Nick Piggin wrote:
> Guy wrote:
> >1} I've seen Nick Piggin's suggestion of nicing X server to
> > -10. At the moment, the only way I know to do this is
> > something like
> >
> ># XSESSION=fluxbox nice --adjustment=-10 startx -- :N
>
> If you're not using my patches then nice causes scheduling
> latency problems so don't do this even if you can. Con's
> scheduler work actually makes interactivity good at the default
> priority.

I don't use this on my reference 2.4.20 kernel. I only tried it to 
see what would happen. This is how I know that I can only do this 
when I'm root. I didn't time anything or do extensive testing. 
Just enough to see that the child processes were also picking up 
the same niceness.

It did occur to me to remember {DOH!} the 'renice' command. It's 
been awhile since I was a *nix admin on an old Sequoia box. 

I have been thinking about trying CK's patchset.

> >A} My default security is that only 'root' can perform nice
> > with negative values. I am reluctant to play with security
> > for such a crticial command.
>
> Debian does this for you. I guess X runs as suid root anyway so
> its not a big security problem.

See comment above. PBSAK

> >B} All child threads inherit the new nice value. So in the
> > example just above, this means all applications started from
> > the GUI desktop run at a nice value of -10. I believe
> > enhancing the X server nice value this way defeats the
> > purpose of nicing it to begin with. Obviously, despite my
> > readings and attempts at research, I'm must be missing
> > something here.
>
> Debian manages to only renice the X server. If something like
> this were required in a distro kernel I guess they would do it
> for you nicely.

See comment above. PBSAK

> >2} I expect to travel down to Florida for Xmass to visit
> > family. One of the things I had hoped to do was to set up my
> > mother's computer as an X server and hang a thin client
> > terminal {read: older PC} off of it. This would allowed my
> > mother and brother to share a reasonably modern system at the
> > same time.
> >
> >This is not me just being cheap. I'm interested in setting up
> >diskless workstations aound a good central X server. I see
> > such setups as appropriate for a number of situations. If the
> > X server requires 'nicing' in a single user environment, what
> > happens in an LTSP environment?
>
> I think the server runs on the clients... or something ;)

The X server on the 'server' is responsible for what to display 
and where to display it.

The X server on the 'client' is responsible for interpreting that 
info for the specific client machines hardware.

Since the 'server' is also responsible for any needed file serving 
yada-yada-yada, I'm not certain how nicing the X server will play 
out. But I'm sure I'll learn soon! However see comment above. 
PBSAK

> >Despite my enthusiasm for 2.6, I find it difficult to get
> >everything to 'just work'. I still see problems in the area of
> >nForce based mobos {stupid proprietary nVidia!}, broken
> > BIOSes, and scheduler issues like the above.
>
> Obviously make sure all your software is up to date with
> Documentation/Changes, and remember we can't help with closed
> drivers. If you still have problems please send in a report.
> Hope this helps

Yes, it helps. 

FWIW, The BIOS is already the lastest available from Asus {Sept. 
2003}.

I'm seeing the same nForce{2,3} problems that other people are 
seeing with regards to all services on the chip except IDE 
sharing a single interrupt with ACPI assigning still other device 
cards to the very same interrupt. This is no longer true for me 
under -test9. :-) I suppose I should find the recent nForce3 
thread and post both my BIOS options and my -test9 config file. 
However, 2.4.20 also has all the nForce services except IDE 
sharing the same interrupt. And that works fine.

I do make an effort to keep up to date. ;-) I saw yesterday and 
plan on loading -test9-mm3 tonight. I even tried the forcedeth 
driver and was unable to boot. I haven't reported that because I 
haven't had time to follow it up with more info other than "It 
won't boot." I try not to make useless posts. When I have more 
info regarding that, I will post it.

Thank you Nick.

Later!

-- 
Recyle computers. Install Gentoo GNU/Linux.

