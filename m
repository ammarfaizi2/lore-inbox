Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSJLNzD>; Sat, 12 Oct 2002 09:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261207AbSJLNzD>; Sat, 12 Oct 2002 09:55:03 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:45993 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S261206AbSJLNzD>; Sat, 12 Oct 2002 09:55:03 -0400
Subject: Small oddity of the week: 2.4.20-pre
From: Alastair Stevens <alastair@camlinux.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Oct 2002 15:00:50 +0100
Message-Id: <1034431251.2688.64.camel@dolphin.entropy.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys - I use the excellent Mindi/Mondo backup & rescue tools on my RH7.3
box, which have worked perfectly throughout a whole range of recent
kernels, up to and including 2.4.19. But, since I started running
2.4.20-pre5 (and now -pre9), Mindi refused to work any more.

I consulted the developer, and we tracked the problem down to this
pathetically innocent command sequence in the script:

    fdisk -l | grep -w "/dev/hda6"

For some reason, this now produces, entirely at _random_, either one or
two lines of output! It was the duplicated output that broke Mindi. It's
easily accommodated in the script, but this randomness was never
exhibited on any earlier kernels. Is it me, or is this weird?

I hope this is useful in some way - anyone got any ideas?

Cheers
Alastair

-- 
 \\ Alastair Stevens                        Cambridge
  \\ Technical Director                        /     \..-^..^...
   \\                                          |Linux solutions \
    \\ 01223 813774                            \     /........../
     \\ www.camlinux.co.uk                      '-=-'
      --

