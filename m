Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTEEUiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTEEUiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:38:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9385 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261301AbTEEUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:38:16 -0400
Date: Mon, 5 May 2003 16:50:45 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200305052050.h45KojH30693@devserv.devel.redhat.com>
To: D.A.Fedorov@inp.nsk.su
cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <mailman.1052142720.4060.linux-kernel2news@redhat.com>
References: <mailman.1052142720.4060.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I use the following calls:
> 
> sys_mknod
> sys_chown
> sys_umask
> sys_unlink
> 
> for creating/deleting /dev entries dynamically on driver
> loading/unloading. It allows me to acquire dynamic major
> number without devfs and external utility of any kind.

Well, duh. "Without devds and external utility" is a no-goal.
You set it, you screw trying to achieve it. It's like a well-known
Russian joke: "[...] We remove the adenoid tissue... through
the anal opening with a blowtorch".

> I use sys_write to output loading/device detection/diagnostic
> messages to process's stderr when appropriate. Yes, it may look as
> "wrong thing" but it uses only legal kernel mechanisms and it saves
> lots of time with e-mail support:
> /sbin/insmod driver verbose=1 2>&1 | mail -s 'it does not works' me@

And pray tell how is syslog different?

-- Pete
