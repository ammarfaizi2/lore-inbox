Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265013AbSKERV1>; Tue, 5 Nov 2002 12:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264990AbSKERV1>; Tue, 5 Nov 2002 12:21:27 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:22958 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S265013AbSKERVV>;
	Tue, 5 Nov 2002 12:21:21 -0500
Message-ID: <3DC7FF9B.AFC268E5@hp.com>
Date: Tue, 05 Nov 2002 10:27:55 -0700
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Paul.Clements@steeleye.com, Khalid Aziz <khalid@fc.hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Retrieve configuration information from kernel
References: <Pine.LNX.4.10.10210291204590.28595-100000@clements.sc.steeleye.com> <3DBED111.96A3A1E8@hp.com> <3DBEE1CE.2060200@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> Khalid Aziz wrote:
> > Paul Clements wrote:
> >
> >>Have you considered compressing the config info in order to reduce
> >>the space wastage in the loaded kernel image? Could easily be 10's of KB
> >>(not that that's a lot these days). The info would then be retrieved via
> >>"gunzip -c", et al. instead of a simple "cat".
> >>
> >
> > I wanted to start with a simple implementation first. There are a couple
> > of things that can be done in future to further improve meory usage: (1)
> > Drop "CONFIG_" and "# CONFIG_" from each line and add it back when
> > printing from /proc/ikconfig and extract-ikconfig script, (2) Compress
> > the resulting configuration. Something to do in near future :)
> 
> Do we really need to store the ones that are not actually set to
> something?  You'll get a bunch of queries when doing a "make oldconfig",
> but saying N to all of them should just work...after all its the ones
> that are actually *set* that we care about.
> 

It is annoying to have to answer a lots of questions when running "make
oldconfig". This also makes your life a little difficult when you are
using the config file from an earlier kernel version to build a newer
kernel. You will get lots of questions to answer including questions for
the new features in the new kernel and you can no longer blindly answer
"N" to every question.

--
Khalid 

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid@hp.com                                       Fort Collins, CO

"The Linux kernel is subject to relentless development" 
				- Alessandro Rubini
