Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWBAPtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWBAPtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWBAPtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:49:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:31679 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161097AbWBAPtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:49:13 -0500
Date: Wed, 1 Feb 2006 16:49:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Julian Bradfield <jcb@inf.ed.ac.uk>
cc: linux-kernel@vger.kernel.org, od@suse.de, lhofhansl@yahoo.com
Subject: Re: TIOCCONS security revisited
In-Reply-To: <17374.5399.546606.933186@palau.inf.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0602011646130.22529@yvahk01.tjqt.qr>
References: <17374.5399.546606.933186@palau.inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>He justified this by claiming that normal users don't need to grab the
>console output.
>
>I disagree. Normal users log into the desktop of their machine, and
>should expect to be able to see the console output just as much as if
>they logged into "the console" and worked without graphics.
>For example, I want to know when the machine I'm working on has
>problems, when somebody is probing sshd, and simply when one of my
>batch jobs wants to tell me something.
>

By console I suppose you mean "printk output", because that's the only 
thing I can decipher from the 'redirecting stuff' in the TIOCCONS function. 
(Reminds me of klogconsole which is some sort of redirector.)

There is one slight problem with tioccons: if kernel output was redirected 
to, say, /dev/pts/1 (some graphical app) and then /dev/pts/1 disappears, 
who is going to set the tioccons back? And to what value?

That's why there is "xconsole", which does read the entire syslog and not 
just console/printk messages.



Jan Engelhardt
-- 
