Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVBPBzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVBPBzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVBPBzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:55:47 -0500
Received: from news.cistron.nl ([62.216.30.38]:53644 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261969AbVBPBz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:55:29 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
 release)
Date: Wed, 16 Feb 2005 01:54:51 +0000 (UTC)
Organization: Cistron
Message-ID: <cuu95b$b5q$1@news.cistron.nl>
References: <20050211004033.GA26624@suse.de> <4211B8FC.8000600@aitel.hist.no> <1108459982.438.9.camel@tara.firmix.at> <4211F706.4030104@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1108518891 11450 194.109.0.112 (16 Feb 2005 01:54:51 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4211F706.4030104@aitel.hist.no>,
Helge Hafting  <helge.hafting@aitel.hist.no> wrote:
>Bernd Petrovitsch wrote:
>>This would be a win (especially if the numbers are tweked to tune this)
>>with a relatively small effort.
>>However for real dependencies and parallelism you want the info similar
>>to creat a Makefile from it (i.e. the explicit dependency from service X
>>to service Y). As a consequence you can get rid of the numbers (since
>>they are not needed any more).
>>
>Now that is a really good idea.  Init could simply run "make -j init2" to
>enter runlevel 2.  A suitable makefile would list all dependencies, and
>of course the targets needed for "init2", "init3" and so on.

It's not too hard to script it using 'tsort', either.

The hard part is getting all the dependencies of the scripts right.
And once you've done that, to _keep_ them right.

Now how do you implement that on a Debian system that is package-wise
somewhere between potato and sarge ... (yes, I've encountered those).

Solveable, not trivial.

Mike.

