Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271184AbTHRB4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 21:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271186AbTHRB4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 21:56:13 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:42258 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id S271184AbTHRB4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 21:56:12 -0400
Date: Sun, 17 Aug 2003 21:56:08 -0400
Message-Id: <200308180156.h7I1u8m9022198@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Cc: Michael Frank <mhf@linuxmail.org>
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-08-16, Michael Frank <mhf () linuxmail ! org> wrote:

> Linux logs almost everything, why not exceptions such as SIGSEGV in
> userspace which may be very informative?

If you really want this, patches to do so have been in hap-linux (2.2.x)
for a while, and they were picked up by grsecurity (2.4).  We both log 
SIGSEGV, SIGBUS, SIGABRT, SIGILL currently; you could add others if you
desired.  The logging is rate-limited to reduce log-flood opportunities
(though as others have mentioned it's quite easy to flood logs through
other means).

--
Hank Leininger <hlein@progressive-comp.com> 
  
