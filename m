Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262340AbRERPen>; Fri, 18 May 2001 11:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262343AbRERPed>; Fri, 18 May 2001 11:34:33 -0400
Received: from [213.96.224.204] ([213.96.224.204]:22800 "HELO manty.net")
	by vger.kernel.org with SMTP id <S262340AbRERPeY>;
	Fri, 18 May 2001 11:34:24 -0400
Date: Fri, 18 May 2001 17:34:13 +0200
From: Santiago Garcia Mantinan <manty@udc.es>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org, Jens David <dg1kjd@afthd.tu-darmstadt.de>
Subject: Re: 8139too on 2.2.19 doesn't close file descriptors
Message-ID: <20010518173413.A797@man.beta.es>
In-Reply-To: <20010518000450.A3755@man.beta.es> <3B04FEE8.FC45EAFE@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B04FEE8.FC45EAFE@uow.edu.au>; from andrewm@uow.edu.au on Fri, May 18, 2001 at 08:52:24PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, that's OK.

I realised about this when I inserted up_and_exit on 2.2 and still it did
the same :-)

> Try putting an
> 	exit_files(current);
> at the start of rtl8139_thread()

Yes, this seems to solve the problem, thanks!

Regards...
-- 
Manty/BestiaTester -> http://manty.net
