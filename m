Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbRHOV6S>; Wed, 15 Aug 2001 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267579AbRHOV6J>; Wed, 15 Aug 2001 17:58:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28943 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267532AbRHOV5y>; Wed, 15 Aug 2001 17:57:54 -0400
Subject: Re: Coding convention of function header comments
To: hzhong@cisco.com (Hua Zhong)
Date: Wed, 15 Aug 2001 23:00:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <no.id> from "Hua Zhong" at Aug 15, 2001 02:41:41 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X8iF-000489-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /**
>  * list_add - add a new entry
>  * @new: new entry to be added
>  * @head: list head to add it after
>  *
>  * Insert a new entry after the specified head.
>  * This is good for implementing stacks.
>  */
> static __inline__ void list_add(struct list_head *new, struct list_head
> *head)
> {
>  __list_add(new, head, head->next);
> }
> 
> Similar to Java.  I want to ask that (1) is this a well-known convention or
> was just invented (informally) by someone here (e.g., Linus?)?  Where can I
> find the documentation about this convention? (2) can anyone point me to the
> URL of similar well-known coding conventions (except the Java one)?

Ok firstly - yes its a straight rip off of the java one. The history is
something like. Gnome needed a format for this, so Michael Zucchi (I
believe) wrote up a hideous perl hack. Miguel de Icaza couldn't get the
format right so it was extended with a free form body. 

Its documented in Documentation/kernel-doc-nano-HOWTO.txt

We do need to improve it to mark up structures, and also to actually
finish the job.
