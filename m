Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282829AbRK0HJM>; Tue, 27 Nov 2001 02:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282830AbRK0HIw>; Tue, 27 Nov 2001 02:08:52 -0500
Received: from web14510.mail.yahoo.com ([216.136.224.169]:36881 "HELO
	web14510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282829AbRK0HIq>; Tue, 27 Nov 2001 02:08:46 -0500
Message-ID: <20011127070845.55943.qmail@web14510.mail.yahoo.com>
Date: Mon, 26 Nov 2001 23:08:45 -0800 (PST)
From: sekhar raja <manamraja@yahoo.com>
Subject: Re: Doubt in Kernel Timers
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011127083602.0d19d985.johnpol@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do we need to Stop the timers if we want to Restart
the timers with new expiry time. 

I see in some implementations the timers are not
stoped before before they restart. Is it correct?

Thanks in Advance
-Rajasekhar

--- Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Mon, 26 Nov 2001 04:55:17 -0800 (PST)
> sekhar raja <manamraja@yahoo.com> wrote:
> 
> > What do i mean is with out Doing add_timer() can
> we
> > use del_timer(). 
> 
> george anzinger is right, you may del_timer() at any
> time.
> If the timer was actually queued, del_timer()
> returns 0, otherwise, it
> returns 1.
> 
> But you should use del_timer_sync() to be sure, that
> your timer function
> is not currentky running on other CPU.
> 
> 
> > Thanks in Advance
> > -Rajasekhar 
> ---
> WBR. //s0mbre


__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
