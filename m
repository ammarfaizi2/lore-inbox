Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264664AbSJTXZC>; Sun, 20 Oct 2002 19:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSJTXZC>; Sun, 20 Oct 2002 19:25:02 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:23427 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264664AbSJTXZB>;
	Sun, 20 Oct 2002 19:25:01 -0400
Date: Sun, 20 Oct 2002 04:28:12 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
cc: Hanna Linder <hannal@us.ibm.com>
Subject: Re: [PATCH] use correct wakeups in fs/pipe.c
Message-ID: <29540000.1035113292@w-hlinder>
In-Reply-To: <3DB1A09A.2070704@colorfullife.com>
References: <3DB1A09A.2070704@colorfullife.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, October 19, 2002 20:12:42 +0200 Manfred Spraul <manfred@colorfullife.com> wrote:

> wake_up_interruptible() and _sync() calls are reversed in pipe_read().
> 
> The attached patches only calls _sync if a schedule() call follows.
> 

FYI. This patch fixes a hang on pipetest.c with the --epoll option.

Thanks!

Hanna

