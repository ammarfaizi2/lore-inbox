Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291790AbSBNRJg>; Thu, 14 Feb 2002 12:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291791AbSBNRJ0>; Thu, 14 Feb 2002 12:09:26 -0500
Received: from [66.150.46.254] ([66.150.46.254]:20844 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S291790AbSBNRJP>;
	Thu, 14 Feb 2002 12:09:15 -0500
Message-ID: <3C6BEF35.20E156E3@wgate.com>
Date: Thu, 14 Feb 2002 12:09:09 -0500
From: Michael Sinz <msinz@wgate.com>
Organization: WorldGate Communications Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; FreeBSD 4.5-STABLE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Core dump file control
In-Reply-To: <3C6BE18F.7B849129@wgate.com.suse.lists.linux.kernel> <363c044a047f1f07d2@[192.168.1.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Michael Sinz <msinz@wgate.com> writes:
> >
> > This then causes core dumps to be of the format:
> >
> >         /coredumps/whale.sinz.org-badprogram-13917.core
> 
> I had something like this for a long time on my todo list. The idea
> was to set core_name_format to the name of a named pipe and have an
> daemon on the other end that logs backtraces to syslogd (something a
> bit like dr.watson)
> Only problem is that it won't handle parallel coredumps very well
> without some additional (deadlock prone) global locking or alternatively
> support AF_UNIX stream sockets too that have the concept of multiple
> streams over a single name.

Ahh, interesting idea.  I have not thought about using pipes since
my main concern was needing to put coredumps into a place that can
not fill up useful disk and, in the case of the diskless nodes, is
writeable since everything else is not.  We just grab the core dumps
later in order to figure out what went wrong.  Under non-development
cases we should get close to zero core dumps.  (Ahh, if that were only
true at this time... :-)

-- 
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.
