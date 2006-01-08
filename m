Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161212AbWAHVmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbWAHVmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161215AbWAHVmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:42:09 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:34944 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1161212AbWAHVmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:42:08 -0500
Date: Sun, 08 Jan 2006 16:41:34 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-reply-to: <Pine.LNX.4.61.0601082158310.8860@spit.home>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1136756494.1043.16.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003ZI97GCY@a34-mta01.direcway.com>
 <200601081734.30349.zippel@linux-m68k.org> <1136746381.1043.10.camel@grayson>
 <Pine.LNX.4.61.0601082158310.8860@spit.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 21:59 +0100, Roman Zippel wrote:
> Hi,
> 
> On Sun, 8 Jan 2006, Ben Collins wrote:
> 
> > Anyway, the problem is that if there is no terminal (e.g. stdout is
> > redirected to a file, and stdin is closed), then kconf loops forever
> > trying to get an answer (NULL is not the same as "").
> 
> Then let's fix the real problem.

That's not entirely acceptable. The reason this shows up is if an
automatic build is being done, and the config files are not up-to-date,
the prefered action is a build failure, not selecting defaults. The
reason for my fix was that instead of filling up diskspace with a
logfile of kconf's infinite loop, we just exit with an error.

Currently, this is the only way to ensure that these issues don't go
unnoticed.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

