Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbTGEAA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 20:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbTGEAAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 20:00:55 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:435 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S266230AbTGEAAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 20:00:54 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Date: Sat, 5 Jul 2003 02:16:27 +0200
User-Agent: KMail/1.5.2
References: <20030703023714.55d13934.akpm@osdl.org>
In-Reply-To: <20030703023714.55d13934.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307050216.27850.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 July 2003 11:37, Andrew Morton wrote:
> . Included Con's CPU scheduler changes.  Feedback on the effectiveness of
>   this and the usual benchmarks would be interesting.
>
>   Changes to the CPU scheduler tend to cause surprising and subtle problems
>   in areas where you least expect it, and these do take a long time to
>   materialise.  Alterations in there need to be made carefully and
>   cautiously. We shall see...

It now tolerates window dragging on this unaccelerated moderately high 
resolution VGA without any sound dropouts.  There are still dropouts while 
scrolling in Mozilla, so it acts much like 2.5.73+Con's patch, as expected. 

I had 2.5.74 freeze up a couple of times yesterday, resulting in a totally 
dead, unpingable system, so now I'm running 2.5.74-mm1 with kgdb and hoping 
to catch one of those beasts in the wild.  The most recent incident occurred 
while switching from X to text console, which did not complete, leaving me 
with no debugging data whatsover.  That was with sound running.  Switching to 
the text console always results in a massive sound skip, so there is a clue.  
XFree is running generic VGA, so I don't seriously suspect the driver, and 
even so, it should not be able to kill the system completely dead.

System details are as I reported earlier:

   AMD K7 1666 (actual) MHz, 512 MB, VIA VTxxx chipset.  Video hardware is
   S3 ProSavage K4M266, unaccelerated VGA mode, 1280x1024x16.  Software is
   2.5.73+Gnome+Metacity+ALSA+Zinf.  Running UP, no preempt.

Regards,

Daniel

