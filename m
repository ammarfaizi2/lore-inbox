Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263344AbUJ2QWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbUJ2QWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263416AbUJ2QSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:18:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3497 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263344AbUJ2QK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:10:29 -0400
Subject: RE: Consistent lock up 2.6.10-rc1-bk7 (mutex/SCHED_RR bug?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew <aathan-linux-kernel-1542@cloakmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       roland@topspin.com, Andrew Morton <akpm@osdl.org>
In-Reply-To: <OMEGLKPBDPDHAGCIBHHJOELLFCAA.aathan-linux-kernel-1542@cloakmail.com>
References: <OMEGLKPBDPDHAGCIBHHJOELLFCAA.aathan-linux-kernel-1542@cloakmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099062404.13098.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 29 Oct 2004 16:07:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-29 at 15:26, Andrew wrote:
> Although it appears I need to fix an applicaiton bug, is it normal/desirable for an application calling system mutex facilities to
> starve the system so completely, and/or become "unkillable"?

If it is SCHED_RR then it may get to hog the processor but it should not
be doing worse than that and should be killable by something higher
priority.

You are right to suspect futexes don't deal with hard real time but the
failure you see isnt the intended failure case.

[Inaky has posted some drafts of a near futex efficient lock system that
ought to work for real time use btw]

Alan

