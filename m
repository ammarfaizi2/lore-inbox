Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbTFLIiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 04:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbTFLIiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 04:38:51 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2945 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264776AbTFLIiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 04:38:50 -0400
Date: Thu, 12 Jun 2003 09:59:56 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306120859.h5C8xuh7000958@81-2-122-30.bradfords.org.uk>
To: jw@pegasys.ws, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Saying it is a bad idea to release a kernel with known bugs
> is like saying it is a bad idea to buy a computer when the
> price will be going down soon.  Would you care to delay
> 2.4.21 until next spring or would you rather get the fixes
> it contains today and have 2.4.22 with your pet fix on
> (hopefully) a scale of weeks?

A lot of the known bugs have fixes which appear to be OK, but haven't
really had enough testing to go in to a -final tree.  A lot of them
won't have been tested on SMP boxes for example.

What _would_ be nice would be to have a -$firstinitial$lastinitial
tree that opens up once we get in to the -rc phase - a kind of
'alternative rc' if you like, which collects all the patches that are
rejected for the official -rc tree.  That gives the maintainers one
last chance to prove the validity of their patch :-).

Or, to look at it other way, it would be effectively carrying on the
-pre phase during the -rc phase:

E.G. 2.4.22 development could look like this:

            2.4.21-final
                 |
                 |
                 V
            2.4.22-pre1
                 |
                 V
            2.4.22-pre2
                 |
                 V
               [snip]
                 |
                 V
            2.4.22-pre6
                 |
                 V
            2.4.22-pre7
                 |             All potential patches are declared
                 V            /    here.
     2.4.22-rc1-----2.4.22-jb1
         |               |
         V               V
     2.4.22-rc2     2.4.22-jb2<-Absolutely nothing new goes in from
         |               |      here on, just fixes.  If it breaks
         V               V      for more than 1 release, it's
       [snip]          [snip]   permenantly deleted from this -jb
         |               |      tree.
         V               V
     2.4.22-rc5     2.4.22-jb7
         |               |
         V               V
     2.4.22-rc6<-MERGE---/
         |         ^
         V         \--------------- Merge of whatever has survived
     2.4.22-rc7<-\                  -jb
         |        ---Delete
         V           anything that's broken in any way, I.E. it has
     2.4.22-final    to be perfect.

John.
