Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313911AbSEPQpg>; Thu, 16 May 2002 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSEPQpf>; Thu, 16 May 2002 12:45:35 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:32272 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S313911AbSEPQpf>;
	Thu, 16 May 2002 12:45:35 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205161645.g4GGjTu29201@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver.
In-Reply-To: <Pine.LNX.4.44.0205161042330.14957-100000@waste.org> from Oliver
 Xymoron at "May 16, 2002 11:22:13 am"
To: Oliver Xymoron <oxymoron@waste.org>
Date: Thu, 16 May 2002 18:45:29 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
        "chen, xiangping" <chen_xiangping@emc.com>,
        "'Jes Sorensen'" <jes@wildopensource.com>,
        "'Steve Whitehouse'" <Steve@ChyGwyn.com>, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Oliver Xymoron wrote:"
> On Thu, 16 May 2002, Peter T. Breuer wrote:
> > Any way of making sure that send_msg on the socket can always get the
> > (known a priori) buffers it needs?
> 
> Not at present. Note that we also need reservations on the receive side
> for ACK handling which is "interesting".

One thing at a time.  What if there is a zone "ceiling" that we keep
lowered exactly until it is time for the process that does the send_msg
to run, when we raise the ceiling.  (I don't know how this VM stuff
works in detail inside - this is an invitation to list the objections).
The scheduler could presumably be trained to muck with the ceilings
according to flags on the process (task?) structs.

Peter
