Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQJ3X0D>; Mon, 30 Oct 2000 18:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQJ3XZy>; Mon, 30 Oct 2000 18:25:54 -0500
Received: from mail2.mail.iol.ie ([194.125.2.193]:14344 "EHLO mail.iol.ie")
	by vger.kernel.org with ESMTP id <S129199AbQJ3XZS>;
	Mon, 30 Oct 2000 18:25:18 -0500
Date: Mon, 30 Oct 2000 23:25:10 +0000
From: Kenn Humborg <kenn@linux.ie>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Third arg to switch_to()
Message-ID: <20001030232509.A14624@excalibur.research.wombat.ie>
In-Reply-To: <20001030191558.A10744@excalibur.research.wombat.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001030191558.A10744@excalibur.research.wombat.ie>; from kenn@linux.ie on Mon, Oct 30, 2000 at 07:15:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 07:15:58PM +0000, I wrote:
> 
> Can anyone point me to an explanation of the third arg to 
> switch_to(prev, next, last)?
> 
> It appeared in 2.2.8.
> 
> What exactly is supposed to be written to it?

Mea culpa...

Further digging revealed that it's for returning prev in the
new task, to deal with the fact that the stack has changed
so local variables in schedule() don't exist anymore.

Later,
Kenn


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
