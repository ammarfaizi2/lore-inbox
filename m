Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbTCIURo>; Sun, 9 Mar 2003 15:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262599AbTCIURo>; Sun, 9 Mar 2003 15:17:44 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46087 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262597AbTCIURn>; Sun, 9 Mar 2003 15:17:43 -0500
Date: Sun, 9 Mar 2003 15:24:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andries.Brouwer@cwi.nl
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
In-Reply-To: <UTC200303090841.h298fLm26761.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.3.96.1030309151802.9062B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> > why its not honouring PTBL values in his case apparently
> 
> The disk capacity code foolishly sets heads to 255, and then
> ide_xlate_1024 decides that we already have chosen a translation,
> so that it does not have to figure out what translation to use.
> 
> Andries

[ code snipped ]

Since you identify this as the problem, do you propose a solution? A flag
indicating that default values are in place, perhaps? Better checks to
ensure that if LBA is used the geometry is forced sane in some way? I
don't think special case code is desirable in this case, at least beyond
checking a flag if that's what's needed.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

