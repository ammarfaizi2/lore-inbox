Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVGAICT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVGAICT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 04:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbVGAICT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 04:02:19 -0400
Received: from ee.oulu.fi ([130.231.61.23]:11945 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S262772AbVGAIB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 04:01:56 -0400
Date: Fri, 1 Jul 2005 11:01:46 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: host protected area fun
Message-ID: <20050701080146.GA2054@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Possible problem documented in irc conversation below, too lazy to rewrite 
all that :-)

Have there been some behavioural changes in this area recently? 
Linux happily overwriting the HPA seems to have happened between 
fc3 and fc4. Could be some userspace partitioning related/bios brokedness
thing too I suppose?

02:04  * pp tries to figure out host protected area stuff
02:04 < pp> _apparently_ these stinkpads have a hidden partition containing
            windows xp etc.
02:04 < pp> which the bios protects
02:04 < pp> linux happily ignores that setting and tries to use that area as
well
02:05 < pp> which works until you eg. resume  from suspend and the area is
            locked again
02:05 < pp> which makes your box pretty unhappy
02:05 < pp> at some point the behaviour was to just ignore the extra space
02:06 < freitag> pp: i think i have machines that print at boot they ignore
the host protected area
02:06 < pp> so whatever is there got nuked :-)
02:07 < pp> apparently could even be bios setup etc. on some models
02:07 < rdd> they can reinstall XP from there too (if it's not nuked)
02:07 < pp> yea
02:08 < pp> basically my laptop went into a state where in "normal" setting
it
            worked until resuming from suspend, after which it got io errors
02:08 < pp> in "secure" mode (no OS access to hpa) the box refused to boot
at all
02:08 < pp> and in "disabled" it's totally happy
02:08 < pp> but the fancy ibm stuff disappeared
02:09 < pp> oh well
02:09 < freitag> tell linux-ide

:-)
