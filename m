Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265636AbUFCQXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbUFCQXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbUFCQXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:23:41 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:17319
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265636AbUFCQXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:23:38 -0400
Message-ID: <40BF501D.5080402@redhat.com>
Date: Thu, 03 Jun 2004 09:21:49 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040601
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040603072146.GA14441@elte.hu>
In-Reply-To: <20040603072146.GA14441@elte.hu>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> gcc's
> PT_GNU_STACK mechanism is very conservative - e.g. if an application
> does an asm() then gcc assumes that it might rely on stack executability
> and emits the X flag. 

Actually, this isn't the case.  asm() alone don't trigger this.  There
are far too many of them in use.  And there never has been a reported
problem.  Only trampolines etc cause gcc to automatically request the X
flag to be set.  In case an asm() indeed causes problems the user can
pass the --execstack option to the linker.

It's all explained in

  http://people.redhat.com/drepper/nonselsec.pdf

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
