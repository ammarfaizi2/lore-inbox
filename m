Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269542AbRHCSWz>; Fri, 3 Aug 2001 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269540AbRHCSWp>; Fri, 3 Aug 2001 14:22:45 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:11 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269538AbRHCSWj>; Fri, 3 Aug 2001 14:22:39 -0400
Date: Fri, 3 Aug 2001 20:22:46 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803202246.E31468@emma1.emma.line.org>
Mail-Followup-To: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010801170230.B7053@redhat.com> <20010802110341.B17927@emma1.emma.line.org> <01080219261601.00440@starship> <20010802193750.B12425@emma1.emma.line.org> <20010802154718.A16494@ead45>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010802154718.A16494@ead45>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2001, Bill Rugolsky Jr. wrote:

> I have no idea where BSD falls, but the basic point stands:  unused
> features should not penalize other applications.  Andrew Morton has
> figured out how to do this efficiently with ext3, and many kudos to him
> for doing the work.  Absent that, why should I have to go get a cup of
> coffee every time I want to patch a tree, just so some MTA can make
> naive assumptions?

The whole idea is to have a switch to turn on BSD-style synchronous
directory update semantics. Nothing more, nothing you would not be able
to get rid off. In fact, you can mount file systems async on BSD as
well, but you'd better not have the machine crash. Irrecoverable file
system damage can result. As a compromise, softupdates are nearly as
fast as async, but FS damage is guaranteed to be recoverable.

In either case (async or soft-updates), files can end up in lost+found
after the control had been returned to the application that called open
or link.

-- 
Matthias Andree
