Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRACXjW>; Wed, 3 Jan 2001 18:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbRACXjN>; Wed, 3 Jan 2001 18:39:13 -0500
Received: from jalon.able.es ([212.97.163.2]:16608 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129324AbRACXi7>;
	Wed, 3 Jan 2001 18:38:59 -0500
Date: Thu, 4 Jan 2001 00:38:50 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Kervin Pierre <kpierre@fit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: /xproc -> /proc files in xml grammer?
Message-ID: <20010104003850.A980@werewolf.able.es>
In-Reply-To: <3A53B08D.F10B96FB@fit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A53B08D.F10B96FB@fit.edu>; from kpierre@fit.edu on Thu, Jan 04, 2001 at 00:06:53 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.04 Kervin Pierre wrote:
> 
> hello,
> 
> Would XML be considered human readable enough for /proc files?  If not,
> how about a /xproc filesystem ( maybe as a kernel build option ), same
> as /proc but uses an xml grammer for reporting.
> I can see tons of uses for this, no more 'fuzzy' parsing for gui
> configuration tools, resource monitors, etc.
> 
> ?
> 
> just thinking aloud really,

More aloud thinkin...

I have seen some times this thread appear on the list. One of the
problems: you will have to force drivers to register in two file
systems...

Perhaps there are tools yet to do what I'm thinkin of: a ghost file
system that just mirrors /proc, changing format of output.

Say you clone the procfs to a fake fs driver (for example, 
procfs.xml) that just translates each fs access system call to

/fproc/xml/path/to/file_or_dir (fproc==formatted proc)

to

/proc/path/to/file_or_dir

reads its contents and reformats them to give the desired output
(now thinkin on read-only, main people interest seems to be
in syntax-ing the out of /proc).

So actual /proc stays, not breaking anything, and theres a way
to write proc info formatters.

Even there could be many common code between all the possible
procfs.XXXX things to ease maintenance.

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre6 #1 SMP Wed Jan 3 21:28:10 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
