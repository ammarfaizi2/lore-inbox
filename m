Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUJEXQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUJEXQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUJEXQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:16:39 -0400
Received: from peabody.ximian.com ([130.57.169.10]:11233 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266319AbUJEXNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:13:08 -0400
Subject: RE: /dev/misc/inotify 0.11 [adr]
From: Robert Love <rml@novell.com>
To: David Busby <busby@edoceo.com>
Cc: linux-kernel@vger.kernel.org, ttb@tentacle.dhs.org
In-Reply-To: <82C88232E64C7340BF749593380762021166FA@seattleexchange.SMC.LOCAL>
References: <82C88232E64C7340BF749593380762021166FA@seattleexchange.SMC.LOCAL>
Content-Type: text/plain
Date: Tue, 05 Oct 2004 19:11:33 -0400
Message-Id: <1097017893.4143.10.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 16:10 -0700, David Busby wrote:

> Here's another issue, when reading from PERL sometimes the filename part
> of the struct inotify_event is wayyyy off.  I'm reading 268 bytes at a
> time, first 12 are the wd,mask and cookie (what is cookie anyways?) then
> 256 for the file name. Isn't that correct?  I'll try to get the
> inotify_test.c program to reproduce.

The cookie is going to be used to connection two related events, such as
MOVED_TO and MOVED_FROM.  Right now it is unused.

We've never seen this problem in inotify_test or Gamin or Beagle ... so
I would suspect this is related to your specific Perl example, but
please let me know if you find anything.

Best,

	Robert Love

