Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUGADf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUGADf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUGADf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:35:26 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:59854 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S263784AbUGADfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:35:20 -0400
Message-ID: <52921.67.8.218.172.1088652919.squirrel@webmail.krabbendam.net>
In-Reply-To: <1088652347.6630.26.camel@timescape.home.snewbury.org.uk>
References: <1088647102.6630.15.camel@timescape.home.snewbury.org.uk>
    <Pine.LNX.4.58.0406302211490.21486@vivaldi.madbase.net>
    <1088649927.6630.21.camel@timescape.home.snewbury.org.uk>
    <1088652347.6630.26.camel@timescape.home.snewbury.org.uk>
Date: Wed, 30 Jun 2004 23:35:19 -0400 (EDT)
Subject: Re: Trouble with the filesize limit
From: "Eric Lammerts" <eric@lammerts.org>
To: "Steven Newbury" <steven.newbury1@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 2004-07-01 at 03:45, Steven Newbury wrote:
>> Okay I've recompiled wget with -D_FILE_OFFSET_BITS=64.  Now I've got:
>> get: progress.c:706: create_image: Assertion `insz <= dlsz' failed.
>> when I try to continue the download...
> This, I guess, is a bug in wget.  Are the various types like size_t set
> correctly for FILE_OFFSET_BITS=64, or should special care be taken
> within each app to ensure types of sufficient size are used?

I'm seeing the use of 'long' throughout the wget source... I guess you're
out of luck regarding wget... And it looks like it won't be fixed anytime
soon:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=181634
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=240281

Eric

