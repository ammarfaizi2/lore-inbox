Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUFWRqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUFWRqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUFWRqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:46:21 -0400
Received: from smtp2.eldosales.com ([63.78.12.18]:48389 "EHLO
	tweeter.eldosales.com") by vger.kernel.org with ESMTP
	id S265037AbUFWRqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:46:19 -0400
Posted-Date: Wed, 23 Jun 2004 10:46:19 -0700
Subject: I/O Confirmation/Problem under 2.6/2.4
From: Ben <ben@easynews.com>
Reply-To: ben@easynews.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Easynews, Inc.
Message-Id: <1088012783.1311.20.camel@solaris.skunkware.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 23 Jun 2004 10:46:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need someone to confirm that linux is capable of doing large amounts
of I/O with hardware raid controllers.  I have tried 4 raid controllers
(2 of which have been confirmed to have issues with linux... namely Dell
PERC *megaraid* series and an Adaptec card *aacraid*) and have not been
able to obtain more then 60MB/s doing hardware raid 5.  The raid cards
I'm testing are quad channel ultra160's with a total of 8 10k 72GB
ultra320 drives (2 per channel) per raid volume... thus I should be able
to do a fairly large amount of I/O (100+MB sequential writes I'd
assume).

I have tried every possible striping configuration a long with multiple
filesystem (ext2/3/xfs) configurations so I do not believe it is an
issue with all 4 cards (I am currently testing a Mylex extremeRaid 2000
and have seen these do much more then 60MB/s in the past on other
platforms).

I've tried tuning elevator settings, read-ahead (in 2.4), and changing
the scheduler under 2.6 between default and deadlock.  Is there
something that needs to be done to get linux to do large amounts of
I/O.  Do the drivers I'm trying (aacraid, megaraid, DAC960, dpt_i2o)
have performance problems?

Please confirm and if possible provide possible settings needed to get
linux in the mode for high i/o or general places to tune I/O.


Thanks,
Ben

