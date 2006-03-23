Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWCWW0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWCWW0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWCWW0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:26:50 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:40324 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932502AbWCWW0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:26:49 -0500
Date: Thu, 23 Mar 2006 15:27:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "Mark A.Greer" <mgreer@mvista.com>, Randy Vinson <rvinson@mvista.com>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH, RFC] Stop using tasklet in ds1374 RTC driver
Message-ID: <20060323222723.GA3379@mag.az.mvista.com>
References: <20060323201030.ccded642.khali@linux-fr.org> <4423084B.1070701@mvista.com> <20060323214028.GB21477@mag.az.mvista.com> <C6071445-B39C-4230-92FA-E8EE5717FD05@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6071445-B39C-4230-92FA-E8EE5717FD05@kernel.crashing.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 03:52:16PM -0600, Kumar Gala wrote:
> 
> On Mar 23, 2006, at 3:40 PM, Mark A. Greer wrote:
> >I'm no expert in workqueues either; however, after reading
> >http://lwn.net/Articles/23634/, I believe that its unnecessary for an
> >rtc driver to have its own workqueue since rtc writes aren't  
> >particularly
> >time-critical.  If I am correct, then Randy's patch uses the proper  
> >wq calls.
> >
> >Agree?
> 
> How does this change with the RTC subsystem that's about to be added?  
> (could be irrelevant, just wanted to put that out there)

Dunno, but its broken where it is now so we need to fix it ASAP.
Once that's done, we can do whatever needs to be done to get it into
drivers/rtc.

Mark
