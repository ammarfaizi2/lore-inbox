Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbRFAPiQ>; Fri, 1 Jun 2001 11:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263584AbRFAPiG>; Fri, 1 Jun 2001 11:38:06 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:18703 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S263211AbRFAPhx>; Fri, 1 Jun 2001 11:37:53 -0400
Date: Fri, 1 Jun 2001 17:37:45 +0200
From: Kurt Roeckx <Q@ping.be>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] which routines must be re-entrant?
Message-ID: <20010601173745.A421@ping.be>
In-Reply-To: <200105312301.QAA16524@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <200105312301.QAA16524@csl.Stanford.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 04:01:34PM -0700, Dawson Engler wrote:
> Is there an easy way to tell which routines must be re-entrant? 
> (it doesn't have to be exhaustive, even an incomplete set is useful)
> 
> I was going to write a checker to make sure supposedly re-entrant
> routines actually were, but was having a hard time figuring out which
> ones were supposed to be...

Their was an post on bugtraq a few days ago about this, it had a
list with all system calls which are reentrant safe under
OpenBSD.  The paper was about signals, and is available at

http://razor.bindview.com/publish/papers/signals.txt

OpenBSD had a manpage wich lists all the function which should be
be safe to call from a signal handler.  It might be a nice
place to start.  You should only look at those from section 2
of course.

http://www.openbsd.org/cgi-bin/man.cgi?query=sigaction



Kurt

