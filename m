Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbRE3V7T>; Wed, 30 May 2001 17:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbRE3V7J>; Wed, 30 May 2001 17:59:09 -0400
Received: from waste.org ([209.173.204.2]:8235 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262829AbRE3V67>;
	Wed, 30 May 2001 17:58:59 -0400
Date: Wed, 30 May 2001 17:00:49 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Dawson Engler <engler@csl.Stanford.EDU>, <linux-kernel@vger.kernel.org>,
        <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] 2.4.5-ac4 non-init functions calling init functions 
In-Reply-To: <26484.991258403@redhat.com>
Message-ID: <Pine.LNX.4.30.0105301658440.29616-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, David Woodhouse wrote:

>
> engler@csl.Stanford.EDU said:
> > drivers/mtd/docprobe.c:195:DoC_Probe: ERROR:INIT: non-init fn
> > 'DoC_Probe' calling init fn 'doccheck'
>
> Strictly speaking, not actually a bug. DoC_Probe() itself is only ever
> called from __init code. But it's probably not worth trying to make the
> checker notice that situation - I've fixed it anyway by making DoC_Probe()
> __init too, which saves a bit more memory. Thanks.

Anything that's only called or used by functions marked init is a
candidate for being marked init. I suspect there's still quite a bit out
there that meets this description.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

