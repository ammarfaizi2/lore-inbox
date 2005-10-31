Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVJaXW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVJaXW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVJaXW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:22:29 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:49225 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932553AbVJaXW2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:22:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PLeZZuB2nOuFyIj0rXHynjZm6TytNjZ+cg08BHy/EU25V+E1MQpjOjcKwKzOPcxnYkVO/f7Dm/bRw8Y7X5Mzq/0txs3NJrS2TUqK0NWc/cHUoYlSduztC1y7Y6HWw2jRFYwhb6p6vQEc+4t69WjSpiX9uUfNBdjuNh+2fOFr7sc=
Message-ID: <5bdc1c8b0510311522r530eefbfmf15b860ac8352824@mail.gmail.com>
Date: Mon, 31 Oct 2005 15:22:27 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rt1 - xruns in a certain circumstance
Cc: "K.R. Foley" <kr@cybsft.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1130776760.32101.40.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com>
	 <50256.192.249.47.11.1130771450.squirrel@webmail2.pair.com>
	 <5bdc1c8b0510310726t105f8f8emd1d044f760a8a1eb@mail.gmail.com>
	 <1130776760.32101.40.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2005-10-31 at 07:26 -0800, Mark Knecht wrote:
> >    I'm going to do as Lee and Ingo suggest, now that I have a test
> > that seems to create xruns pretty qickly. Hopefully I'll capture
> > something of interest. However I'm questioning exactly what the video
> > problem would be since I don't create xruns when watching MythTV full
> > screen. Only get them when watching in this preview window. That said
> > it is an ATI PCI-Express card but since it's 2.6.14 there is no ATI
> > driver support. My kernel is currently trying to load fglrx (the ATI
> > driver) and failing since it doesn't support this kernel. I'll clean
> > up the video driver setup and retest.
>
> Please try my first suggestion, just set Option "NoAccel" to the Device
> section of your xorg.conf.
>
> Lee

Well, unfortuantely, after working along for quite a while with no
problems I ran into another rash of xruns:
13:30:42.524 Audio connection graph change.
subgraph starting at qjackctl-9003 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
13:49:44.441 XRUN callback (1).
**** alsa_pcm: xrun of at least 1.575 msecs
subgraph starting at qjackctl-9003 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
13:53:54.253 XRUN callback (2).
**** alsa_pcm: xrun of at least 0.889 msecs
**** alsa_pcm: xrun of at least 8.928 msecs
13:53:56.006 XRUN callback (1 skipped).
subgraph starting at qjackctl-9003 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
13:58:39.856 XRUN callback (4).
**** alsa_pcm: xrun of at least 0.669 msecs
subgraph starting at qjackctl-9003 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
14:40:37.943 XRUN callback (5).
**** alsa_pcm: xrun of at least 1.056 msecs
subgraph starting at qjackctl-9003 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
14:53:54.885 XRUN callback (6).
**** alsa_pcm: xrun of at least 0.713 msecs
**** alsa_pcm: xrun of at least 28.928 msecs
14:53:56.711 XRUN callback (1 skipped).

In this case I was not using MythTV. I was building some code as part
of an emerge world, playing some music off a 1394 drive, and chatting
on the Gentoo-ppc IRC.

It seems that my system is not there quite yet.

I took a quick look. If you get a chance where does the NoAccel option
go? Inside of the section for the radeon driver? I'm sure I can find
this online but won't have much of an opportunity for the next few
hours.

Cheers,
Mark
