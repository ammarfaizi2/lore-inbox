Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTBANZO>; Sat, 1 Feb 2003 08:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTBANZO>; Sat, 1 Feb 2003 08:25:14 -0500
Received: from kunde0416.oslo-asen.alfanett.no ([62.249.189.163]:58894 "EHLO
	kunde0416.oslo-asen.alfanett.no") by vger.kernel.org with ESMTP
	id <S264844AbTBANZN>; Sat, 1 Feb 2003 08:25:13 -0500
Date: Sat, 1 Feb 2003 14:34:29 +0100 (CET)
From: Peter Karlsson <peter@softwolves.pp.se>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 kernel crashes while scanning partition list
In-Reply-To: <m365sclylx.fsf@varsoon.wireboard.com>
Message-ID: <Pine.LNX.4.43.0302011417500.11193-100000@perkele>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught:

> Have you tried 2.4.21pre?  It may have fixes to handle newer hardware.

I tried the 2.4.21pre4, and it crashes as well, seemingly in the exact
same spot as the other kernels. I also tried 2.5.59, but I couldn't get
it to find the array at all (it does list the IDE channels, though).

Here's a summary of what happens:

  Kernel        Finds IDE?  Finds array?  Finds partitions
  ------        ----------  ------------  ----------------
  2.4.18        No          Yes*          Yes, and boots fine
  2.4.19        Yes         Yes           Crashes when enumerating
  2.4.20        Yes         Yes           Crashes when enumerating
  2.4.21pre4**  Yes         No            No partitions found
  2.4.21pre4*** Yes         Yes           Crashes when enumerating
  2.5.59        Yes         No            No partitions found

* When fed IDE channels on the command line
** With configuration copied from 2.4.20.
*** Enabled the non-ataraid options for Promise FastTrak.

The configuration for 2.4.19--21 should be the same. 2.4.18 is
pre-built version from Debian's boot-floppies. Source for 2.4.21pre4
and 2.5.59 are pristine kernel.org sources. (My 2.5.59 configuration
might have been flawed, however.)

As before, all relevant debugging material may be found at
<URL:http://www.softwolves.pp.se/tmp/2.4.20>


I could really need some help debugging. I can set up an account on my
machine (I have a cable tv connection), and set up a null modem cable
from the problematic machine if that would be helpful. I don't really
know much about kernel debugging, especially when it crashes before the
system has actually started up.

-- 
\\//
Peter

  I do not read or respond to mail with HTML attachments.


