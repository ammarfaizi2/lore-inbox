Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265861AbUFDQxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265861AbUFDQxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUFDQxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:53:06 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:56756
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265861AbUFDQxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:53:03 -0400
Message-ID: <40C0A87A.3060609@redhat.com>
Date: Fri, 04 Jun 2004 09:51:06 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040601
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604154142.GF16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org> <20040604155138.GG16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> If things are really that good, why are we even worrying about this?
> 
> It sounds like we should just have NX on by default even for executables
> that don't have any NX info records,

This is possible in one of the modes the FC kernel supports but not a
good default.

While most of the code we ship has no problems, 3rd party code is a
completely different story.  Most of the time this code is not as
cleanly written as the (cleaned-up) code we ship.  If anything, you can
announce your intention to change the default in a few years and urge
people to clean up their code.  If you want the maximum protection now
go with Ingo's exec-shield patch and the /proc/sys/kernel/exec-shield
entry which can be set to 2 to enable the strict mode.  That's certainly
the best solution for edge servers but not for application servers
running lots of dubious 3rd party code.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
