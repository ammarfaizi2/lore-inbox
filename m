Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSBRW7T>; Mon, 18 Feb 2002 17:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288897AbSBRW7J>; Mon, 18 Feb 2002 17:59:09 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:43461 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S288870AbSBRW6z>; Mon, 18 Feb 2002 17:58:55 -0500
Message-ID: <3C718901.2105C7B5@nortelnetworks.com>
Date: Mon, 18 Feb 2002 18:06:41 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Craig-Wood <ncw@axis.demon.co.uk>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: time goes backwards periodically on laptop if booted in low-power 
 mode
In-Reply-To: <3C6FDB8C.9B033134@kegel.com> <20020218213049.A28604@axis.demon.co.uk> <3C71780F.6377F8D9@nortelnetworks.com> <20020218221214.A29199@axis.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Craig-Wood wrote:
> 
> On Mon, Feb 18, 2002 at 04:54:23PM -0500, Chris Friesen wrote:
> > Nick Craig-Wood wrote:
> > > I made a patch to fix this (this is its first outing).  It stops
> > > do_gettimeofday reporting a time less than it reported last time.
> >
> > I see a minor problem here...what happens if you want to reset your clock (for
> > whatever purpose) to a previous time?
> 
> Sorry that was a simplified explanation above.

Ooops, my bad (should've read the patch more closely).  Time offsets can't go
backwards if jiffies stays the same.  As long as jiffies is changed, then the
patch has no effect.  Got it.


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
