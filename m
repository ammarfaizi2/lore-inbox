Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTJFACb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 20:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbTJFACa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 20:02:30 -0400
Received: from hacksaw.org ([66.92.70.107]:13236 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id S263903AbTJFAC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 20:02:28 -0400
Message-Id: <200310060002.h9602LCY009821@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: swap and 2.4.20 
In-reply-to: Your message of "Sun, 05 Oct 2003 16:49:37 PDT."
             <20031005234937.GG1205@matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Oct 2003 20:02:21 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What you are talking about is equivalent to binary patching.

Sure, just a bit safer.

>If you have an app that needs to be available every second, then you need a
>failover system, and why not just have three where you can take one down at
>any time for updates(and still have one for failover during the update,
>though you could get by with only two, and take down the fail-over machine
>during the update)? 

Well, the most obvious reason is that there is a unique state in the program 
that you wish to preserve. A possibly pathological scenario is this:

You have a machine controlling a physical process, say a robotic crane. It's 
currently holding up a big piece of work, and moving it the wrong way would be 
very bad.

You have just discovered that the movement routine fails to take some physical 
circumstance into account. If you could replace the routine in situ, there's 
no serious loss. However, stopping and restart the program is no good, because 
it automatically homes the crane, and more importantly, can't restart a 
movement routine in the middle.

A design failure? Sure, but a realistic scenario.


-- 
Signposts are useful when you know where you're going.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


