Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbTESOPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 10:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbTESOPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 10:15:35 -0400
Received: from franka.aracnet.com ([216.99.193.44]:61350 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262483AbTESOPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 10:15:34 -0400
Date: Mon, 19 May 2003 07:28:22 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: ptb@it.uc3m.es, William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <34270000.1053354500@[10.10.2.4]>
In-Reply-To: <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
References: <200305181724.h4IHOHU24241@oboe.it.uc3m.es>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's a problem looking for a solution!  No, the reason for wanting a
> recursive spinlock is that nonrecursive locks make programming harder.

And more correct.
 
> Though I've got quite good at finding and removing deadlocks in my old
> age, there are still two popular ways that the rest of the world's
> prgrammers often shoot themselves in the foot with a spinlock:
> 
>    a) sleeping while holding the spinlock
>    b) taking the spinlock in a subroutine while you already have it

So ... we should BUG() on both.

M.
