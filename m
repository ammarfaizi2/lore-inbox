Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTDHM7H (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 08:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbTDHM7H (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 08:59:07 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:44254 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S261352AbTDHM7G (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 08:59:06 -0400
Date: Tue, 8 Apr 2003 09:06:56 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304080910_MC3-1-337C-B9A7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Have you looked at Stellation at all?  I know the
>> code itself is Java but they have some neat ideas about
>> being able to take 'slices' across the repository and
>> treat the slice as a single file for things like revision
>> tracking.  
>
> Except that those are ideas as far as I can tell, not actual code.


 Last I saw they had a prototype that worked better than they expected.



>  In the
>for what it is worth department, we've done this internally and found
>it doesn't work as well as you might hope.  Sometimes there are clear
>delinations and you really can move stuff around but most of the time
>there is stuff built on top of the stuff you want to move and there is
>no way for a program to tell the difference between enhancements vs fixes
>to the original change.


I wouldn't expect the system to be able to do that any better than it can
resolve every merge conflict.  And at the very least I'd like to be able
link changesets together so that if I pull cset 1 and there is a mandatory
fix applied to it, I at least get a pointer to the changes.  Something
like this:

  1. Keep the csets separate but link them together.  Let the developer
     tell the system whether one is an enhancement or a bugfix to the base.

  2. Conflicts can be resolved when someone pulls any member of the group.


Stellation is also nice becuase it's built on a SQL database.  This gains
you all the features of the DBMS you run it on, like rollback of failed
transactions and point-in-time recovery.

--
 Chuck
