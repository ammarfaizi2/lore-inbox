Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271364AbRHTQRo>; Mon, 20 Aug 2001 12:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271335AbRHTQQy>; Mon, 20 Aug 2001 12:16:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12041 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271332AbRHTQQn>; Mon, 20 Aug 2001 12:16:43 -0400
Subject: Re: [PATCH] Prevent reuse of active thread group id
To: dmccr@us.ibm.com (Dave McCracken)
Date: Mon, 20 Aug 2001 17:19:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <87110000.998321704@baldur> from "Dave McCracken" at Aug 20, 2001 10:35:04 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YrmD-0006JL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The thread group id of a task is initially assigned the value of that 
> task's pid, then is inherited for each child task created with 
> CLONE_THREAD.  This patch makes sure that the thread group id is never 
> re-used as another task's pid as long as there's an active task with that 
> tgid.

Looks a sensible precaution, otherwise a kill might go to very wrong places.
I'll apply it
