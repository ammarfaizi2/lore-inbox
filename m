Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271033AbTHQUyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271037AbTHQUyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:54:15 -0400
Received: from unthought.net ([212.97.129.24]:2230 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S271033AbTHQUyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:54:11 -0400
Date: Sun, 17 Aug 2003 22:54:07 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: Valdis.Kletnieks@vt.edu, Michael Frank <mhf@linuxmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Message-ID: <20030817205407.GA27725@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"David D. Hagood" <wowbagger@sktc.net>, Valdis.Kletnieks@vt.edu,
	Michael Frank <mhf@linuxmail.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200308170410.30844.mhf@linuxmail.org> <200308162049.h7GKnwnP024716@turing-police.cc.vt.edu> <3F3EB8FA.1080605@sktc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F3EB8FA.1080605@sktc.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 06:06:34PM -0500, David D. Hagood wrote:
> Valdis.Kletnieks@vt.edu wrote:
> 
> >Consider this code:
> >
> >	char *foo = 0;
> >	sigset(SIGSEGV,SIG_IGNORE);
> >	for(;;) { *foo = '\5'; }
> >
> >Your logfiles just got DoS'ed....
...

Consider this code:
 for (;;) syslog(LOG_INFO, "root, hurt me please!");

My point being, that if a user wishes to spam the syslog he can.

Please read the syslogd man page - see under "SECURITY THREATS".
Especially option 5 in that section:

----------------
5.     Use step 4 and if the problem persists and is not secondary to a  rogue
       program/daemon get a 3.5 ft (approx. 1 meter) length of sucker rod* and
       have a chat with the user in question.

       Sucker rod def. -- 3/4, 7/8 or 1in. hardened steel rod, male  threaded
       on  each  end.  Primary use in the oil industry in Western North Dakota
       and other locations to pump 'suck' oil from oil wells.  Secondary  uses
       are  for  the construction of cattle feed lots and for dealing with the
       occasional recalcitrant or belligerent individual.
----------------

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
