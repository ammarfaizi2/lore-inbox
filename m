Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130881AbRAaTaT>; Wed, 31 Jan 2001 14:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131208AbRAaTaK>; Wed, 31 Jan 2001 14:30:10 -0500
Received: from 4dyn210.com21.casema.net ([212.64.95.210]:8975 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S130881AbRAaTaA>;
	Wed, 31 Jan 2001 14:30:00 -0500
Date: Wed, 31 Jan 2001 20:29:41 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linuxrc runs with PID 7
Message-ID: <20010131202940.A17658@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010131192338.19211.qmail@web117.yahoomail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <20010131192338.19211.qmail@web117.yahoomail.com>; from moloch16@yahoo.com on Wed, Jan 31, 2001 at 11:23:38AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 11:23:38AM -0800, Paul Powell wrote:
> This is a followup question to my previous question
> "Why isn't init at PID 1."

Lots of stuff assumes that PID 0 is the idle task, and that PID 1 is init.
For example, the kernel disallows ptraceing of init, based on its pid of 1.

If you are PID 1, make sure that you handle SIGCHLDs etcetera from daemons.
Check the source of init, I suspect it does something which tells the kernel
'I am your init'.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
