Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbUADQfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbUADQfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:35:16 -0500
Received: from luli.rootdir.de ([213.133.108.222]:19359 "EHLO luli.rootdir.de")
	by vger.kernel.org with ESMTP id S265751AbUADQfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:35:08 -0500
X-Qmail-Scanner-Mail-From: claas@rootdir.de via luli
X-Qmail-Scanner: 1.20 (Clear:RC:1(217.186.136.12):SA:0(-4.4/5.0):. Processed in 0.207289 secs)
Date: Sun, 4 Jan 2004 17:35:07 +0100
From: Claas Langbehn <claas@rootdir.de>
To: =?iso-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: atyfb broken
Message-ID: <20040104163507.GA1643@rootdir.de>
References: <20040104005246.GA2153@rootdir.de> <Pine.LNX.4.44.0401041040480.28807-402000@deadlock.et.tudelft.nl> <20040104110941.GA983@rootdir.de> <20040104121019.GB1073@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040104121019.GB1073@rootdir.de>
Reply-By: Wed Jan  7 17:14:06 CET 2004
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.1-rc1 i686
X-No-archive: yes
X-Uptime: 17:14:06 up  6:05,  8 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniël,


(the follwing is made with 2.4.23:)

at first I want to thank you again for helping me to debug this bug.
After you left irc, i continued to debug, with the following results:

First, I need to enable CONFIG_FB_ATY_GENERIC_LCD. But I dont need 
to patch it. around the hack for Geerts notebook.

Second, I need to enable "Video Expansion" in system bios.
(At lower resolutions, video is expanded to cover the entire LCD)

If I dont enable Video Expansion, the 640x480-60 and 800x600-60
resolutions are broken. Repairing by pressing Fn-F5 is possible,
though. In that case booting with video=atyfb:1024x768-8@60 helped
to get at least that resolution working.

Have a look at my debugging logs 10.log - 16.log at
http://www.rootdir.de/files/atyfb/. 


regards, claas


