Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUJEX1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUJEX1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUJEX1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:27:03 -0400
Received: from secundus.edoceo.com ([216.162.208.165]:57474 "EHLO
	secundus.edoceo.com") by vger.kernel.org with ESMTP id S266275AbUJEXVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:21:54 -0400
From: "David Busby" <busby@edoceo.com>
To: "'Robert Love'" <rml@novell.com>
Cc: <linux-kernel@vger.kernel.org>, <ttb@tentacle.dhs.org>
Subject: RE: /dev/misc/inotify 0.11 [adr]
Date: Tue, 5 Oct 2004 16:21:49 -0700
Message-ID: <82C88232E64C7340BF749593380762021166FB@seattleexchange.SMC.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <1097017893.4143.10.camel@betsy.boston.ximian.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's my PERL, I've just run a test.  inotify_test.c works correctly and
shows the proper filenames.  My PERL script is sometims dropping the
first character, I've not been able to re-product the full junk ouput
(it was all Java source code!?).  I'll keep hunting.  Is there a place I
can subscribe to the inotify-announce list?

/djb

> -----Original Message-----
> From: Robert Love [mailto:rml@novell.com] 
> Sent: Tuesday, October 05, 2004 4:12 PM
> To: David Busby
> Cc: linux-kernel@vger.kernel.org; ttb@tentacle.dhs.org
> Subject: RE: /dev/misc/inotify 0.11 [adr]
> 
> 
> On Tue, 2004-10-05 at 16:10 -0700, David Busby wrote:
> 
> > Here's another issue, when reading from PERL sometimes the filename 
> > part of the struct inotify_event is wayyyy off.  I'm 
> reading 268 bytes 
> > at a time, first 12 are the wd,mask and cookie (what is cookie 
> > anyways?) then 256 for the file name. Isn't that correct?  
> I'll try to 
> > get the inotify_test.c program to reproduce.
> 
> The cookie is going to be used to connection two related 
> events, such as MOVED_TO and MOVED_FROM.  Right now it is unused.
> 
> We've never seen this problem in inotify_test or Gamin or 
> Beagle ... so I would suspect this is related to your 
> specific Perl example, but please let me know if you find anything.
> 
> Best,
> 
> 	Robert Love
> 
> 

