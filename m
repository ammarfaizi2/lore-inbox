Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSBRVrE>; Mon, 18 Feb 2002 16:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287895AbSBRVqp>; Mon, 18 Feb 2002 16:46:45 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:60601 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S287865AbSBRVqg>; Mon, 18 Feb 2002 16:46:36 -0500
Message-ID: <3C71780F.6377F8D9@nortelnetworks.com>
Date: Mon, 18 Feb 2002 16:54:23 -0500
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
In-Reply-To: <3C6FDB8C.9B033134@kegel.com> <20020218213049.A28604@axis.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Craig-Wood wrote:
> 
> On Sun, Feb 17, 2002 at 08:34:20AM -0800, Dan Kegel wrote:
> > My Toshiba laptop (running stock Red Hat 7.2, kernel 2.4.7-10)
> > appears to suffer from a power management-related time hiccup: when
> > I boot in low-power mode, then switch to high-power mode,
> > time goes backwards by 10ms several times a second.
> > According to the thread
> >  Subject:  [PATCH]: allow notsc option for buggy cpus
> >  From:     Anton Blanchard <anton@linuxcare.com.au>
> >  Date:     2001-03-10 0:58:29
> >  http://marc.theaimsgroup.com/?l=linux-kernel&m=98418670406359&w=2
> > this can be fixed by disabling the TSC option, but there
> > ought to be a runtime fix.  Was a runtime fix ever put
> > together for this situation?
> 
> All the IBM thinkpads we have in the office have exactly this problem.
> The major symptom is that ALT-TAB goes wrong in the sawfish window
> manager oddly!
> 
> I made a patch to fix this (this is its first outing).  It stops
> do_gettimeofday reporting a time less than it reported last time.

I see a minor problem here...what happens if you want to reset your clock (for
whatever purpose) to a previous time?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
