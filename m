Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbREMPSc>; Sun, 13 May 2001 11:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbREMPSM>; Sun, 13 May 2001 11:18:12 -0400
Received: from geos.coastside.net ([207.213.212.4]:18366 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261410AbREMPSK>; Sun, 13 May 2001 11:18:10 -0400
Mime-Version: 1.0
Message-Id: <p05100311b72454f710ce@[207.213.214.37]>
In-Reply-To: <E14ycUa-0004K0-00@the-village.bc.nu>
In-Reply-To: <E14ycUa-0004K0-00@the-village.bc.nu>
Date: Sun, 13 May 2001 08:15:08 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: ENOIOCTLCMD?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:43 PM +0100 2001-05-12, Alan Cox wrote:
>  > That's what's confusing me: why the distinction? It's true that the
>>  current scheme allows the dev->ioctlfunc() call below to force ENOTTY
>>  to be returned, bypassing the switch, but presumably that's not what
>>  one wants.
>
>It allows driver specific code to override generic code, including 
>by reporting
>that a given feature is not available/appropriate.
>
>Alan

What I was arguing (conceptually) is that something like

#define ENOIOCTLCMD ENOTTY

or preferably but more invasively s/ENOIOCTLCMD/ENOTTY/ (mutatis mutandis)

would result in no loss of function. I assert that ENOIOCTLCMD is 
redundant, pending a specific counterexample.
-- 
/Jonathan Lundell.
