Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWAIEAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWAIEAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 23:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWAIEAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 23:00:04 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:64807 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1751236AbWAIEAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 23:00:02 -0500
Date: Sun, 08 Jan 2006 22:59:13 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-reply-to: <200601090109.06051.zippel@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1136779153.1043.26.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003ZI97GCY@a34-mta01.direcway.com>
 <Pine.LNX.4.61.0601082158310.8860@spit.home>
 <1136756494.1043.16.camel@grayson> <200601090109.06051.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 01:09 +0100, Roman Zippel wrote:
> Hi,
> 
> On Sunday 08 January 2006 22:41, Ben Collins wrote:
> 
> > That's not entirely acceptable. The reason this shows up is if an
> > automatic build is being done, and the config files are not up-to-date,
> > the prefered action is a build failure, not selecting defaults. The
> > reason for my fix was that instead of filling up diskspace with a
> > logfile of kconf's infinite loop, we just exit with an error.
> >
> > Currently, this is the only way to ensure that these issues don't go
> > unnoticed.
> 
> Then something is wrong with your automatic build. If the config needs to be 
> updated and stdin is redirected during a kbuild, it will already abort.

And what should be directed into stdin? Nothing. There should be no
input going into an automated build, exactly because it could produce
incorrect results.

BTW, this is the automatic build that Debian and Ubuntu both use (in
Debian's case, used for quite a number of years). So this isn't
something I whipped up.

Still, the build system shouldn't have to do anything special with stdin
to get the desired result. The code should also not react differently
based on stdin being closed, or being pumped with nul data.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

