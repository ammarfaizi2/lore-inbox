Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270462AbTHQSqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270498AbTHQSqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:46:16 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:24192 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270462AbTHQSqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:46:15 -0400
Date: Sun, 17 Aug 2003 19:46:02 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030817184602.GA3191@mail.jlokier.co.uk>
References: <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net> <5.2.1.1.2.20030817072115.0198f398@pop.gmx.net> <5.2.1.1.2.20030817100457.019d0c70@pop.gmx.net> <5.2.1.1.2.20030817195509.019d2de8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030817195509.019d2de8@pop.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> ...once the shadow task is enqueued and runnable, there's nothing to 
> prevent the worker thread from exhausting it's slice before it can put it's 
> shadow back to sleep.

This is why the shadow needs to check whether the active task is
runnable when the shadow returns from FUTEX_WAIT.  Reading
/proc/pid/stat alas, but hey that's what we have.

-- Jamie
