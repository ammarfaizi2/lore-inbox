Return-Path: <linux-kernel-owner+w=401wt.eu-S964847AbXAJLi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbXAJLi0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 06:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbXAJLi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 06:38:26 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:54153 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964847AbXAJLiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 06:38:25 -0500
Date: Wed, 10 Jan 2007 12:31:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
In-Reply-To: <Pine.LNX.4.64.0701091520280.3594@woody.osdl.org>
Message-ID: <Pine.LNX.4.61.0701101223150.3029@yvahk01.tjqt.qr>
References: <20070109102057.c684cc78.khali@linux-fr.org>
 <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org>
 <20070109133121.194f3261.akpm@osdl.org> <Pine.LNX.4.64.0701091520280.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 9 2007 15:21, Linus Torvalds wrote:
>
>Actually, how about just removing the incrementing version count entirely?
>
>I realize that it's really really old, and has been there basically since 
>day one, but on the other hand, it's old not because it's fundamentally 
>important, but because it's just been maintained. How about just dropping 
>it entirely?
>
>We have more useful _real_ versioning these days, with git commit ID's 
>etc.

Like other people said, scripts rely on it. Not just kernel-build
scripts or thelike. Note that this local build ID is _also_ in
/proc/version, meaning that every possible script out there has
code/regex to skip or read that one field.

E.g.
($ver, $builder, $gcc, $id, $flags, $date) =
  ($_ =~ /^Linux version (\S+) \((\S+)\) \((.*)\) (#\d+) (.*) ((?:Mon|Tue|Wed|Thu|Fri|Sat|Sun).*)/);


Oh well we could also put a static "#0" in there, but it also has
its uses (see replies from other people).

	-`J'
-- 
