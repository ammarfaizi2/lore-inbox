Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbSIXVhi>; Tue, 24 Sep 2002 17:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbSIXVhi>; Tue, 24 Sep 2002 17:37:38 -0400
Received: from port-216-3073641-iml104.devices.datareturn.net ([216.46.230.105]:53006
	"EHLO sportvision.com") by vger.kernel.org with ESMTP
	id <S261831AbSIXVhh> convert rfc822-to-8bit; Tue, 24 Sep 2002 17:37:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roberto Peon <robertopeon@sportvision.com>
Reply-To: robertopeon@sportvision.com
Organization: Sportvision Inc.
To: Rik van Riel <riel@conectiva.com.br>,
       Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Date: Tue, 24 Sep 2002 14:35:16 -0700
User-Agent: KMail/1.4.1
Cc: David Schwartz <davids@webmaster.com>, <pwaechtler@mac.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209241822080.15154-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0209241822080.15154-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209241435.17009.robertopeon@sportvision.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 24 September 2002 02:22 pm, Rik van Riel wrote:
> On Tue, 24 Sep 2002, Chris Friesen wrote:
> > David Schwartz wrote:
> > > 	The main reason I write multithreaded apps for single CPU systems is
> > > to protect against ambush. Consider, for example, a web server. Someone
> > > sends it an obscure request that triggers some code that's never run
> > > before and has to fault in. If my application were single-threaded, no
> > > work could be done until that page faulted in from disk.

This is similar to the problems that we face doing realtime virtual video
enhancements-

We have to log camera data (to know where things are pointed) by video
timecode since the data for the camera and the video are asyncronous
(especially in replay). 

These (mmaped) logs can get relatively large (100+ MB ea) and access into them
is relatively random (i.e. determined by the director of the show), so the
process reading the log (and suffering the fault) is in a different thread in
order to not stall the other important tasks such as video output.
(Mis-estimating the position for the enhancement is much less of an issue than
dropping the video frame itself. We don't want 10,000,000 people seeing
pure-green frames popping up in the middle of the broadcast.)

-Roberto JP
robertopeon@sportvision.com


