Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUGMThn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUGMThn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 15:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUGMThn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 15:37:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28834 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264913AbUGMThl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 15:37:41 -0400
Date: Tue, 13 Jul 2004 21:36:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: suspend/resume success and failure report and questions
Message-ID: <20040713193640.GG3654@openzaurus.ucw.cz>
References: <20040710083027.GB27827@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710083027.GB27827@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	But generally, big thanks to the pmdisk developer(s), it is
> 	working great! Even multiple suspend/resume cycles etc.
> 	Only thing I am missing is some way of post-resume script.

echo 4 > /proc/acpi/sleep; post_resume_script

> - partial Suspend2Ram via mem > /sys/power/state
> 	Here all the usb stuff has to be compile modular and has to be
> 	unloaded, no radeon framebuffer and no X is allowed.
> 	Then suspend to ram works, resume too, but the video card is 
> 	not initialized again. Black screen. But I can shut down.
>

See video.txt. Perhaps usb & radeon need some more
suspend/resume support?
 
> - network drivers (b44)

Should work ok.

> - is there a way to get things done BEFORE the suspend (this I managed via 
>   the acpi script), but also AFTER the resume.
>   I need this for fixing the clock and starting mysql and some more stuff

Yes.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

