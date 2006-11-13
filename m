Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754641AbWKMQeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbWKMQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbWKMQeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:34:09 -0500
Received: from kurby.webscope.com ([204.141.84.54]:57495 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1754641AbWKMQeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:34:08 -0500
Message-ID: <45589E2E.7070304@linuxtv.org>
Date: Mon, 13 Nov 2006 11:32:46 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Jos=E9_Su=E1rez?= <j.suarez.agapito@gmail.com>
CC: linux-dvb@linuxtv.org, Mauro Carvalho Chehab <mchehab@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "pasky@ucw.cz" <pasky@ucw.cz>
Subject: Re: [linux-dvb] Avermedia 777 misbehaves after remote hack merged
 into	v4l-dvb tree
References: <200611131711.46626.j.suarez.agapito@gmail.com>
In-Reply-To: <200611131711.46626.j.suarez.agapito@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

José Suárez wrote:
> Hi to everybody.
> 
> I am using an Avermedia 777 DVB-T pci card. It is a very nice card, and it's 
> been working perfectly for the last weeks. However I decided to make an 
> upgrade to the current revision of the v4l-dvb tree which includes support 
> for the remote control. After the upgrade whenever I start the TV (with 
> whatever program: kaffeine, mythtv,...) it happens just as if the TV card 
> kept sending keyboard events all the time and as a result, the volume mutes, 
> unmutes, amarok is launched,... (that's because I have a multimedia keyboard 
> and some keys are mapped to do that). For example, when I launch mythbackend 
> in a konsole window, the application starts, opens the TV card and suddenly 
> what happens is like if keys got pressed, so for example there appears 771935 
> in the console window.
> This happens all the time the TV card is open. I suggest that somebody takes a 
> look at the remote control code because there must be the problem, as I have 
> just installed the v4l-dvb revision which existed just before to the remote 
> control commitment.
> 
> All the best, José

The author of that patch had explained that he was unable to test it.  The patch
was merged into the v4l-dvb master development repository over the weekend, and
Mauro sent a pull request for this patch to go to 2.6.19 a few hours ago.  I 
don't know why this was sent to the 2.6.19 tree without first being tested. :-(

Mauro -- that patch needs fixing / more testing before it goes to mainstream...

Could you please remove that changeset from your git tree before Linus pulls it?

The problem changeset:

git commit 450efcfd2e1d941e302a8c89322fbfcef237be98

V4L/DVB (4814): Remote support for Avermedia 777

http://www.kernel.org/git/?p=linux/kernel/git/mchehab/v4l-dvb.git;a=commit;h=450efcfd2e1d941e302a8c89322fbfcef237be98


-- 
Michael Krufky

