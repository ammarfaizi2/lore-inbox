Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282139AbRK1MSg>; Wed, 28 Nov 2001 07:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282131AbRK1MSZ>; Wed, 28 Nov 2001 07:18:25 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:3983 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S282136AbRK1MSN>;
	Wed, 28 Nov 2001 07:18:13 -0500
Date: Wed, 28 Nov 2001 12:18:08 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Frank Cornelis <Frank.Cornelis@rug.ac.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: task_struct.mm == NULL
In-Reply-To: <Pine.GSO.4.31.0111281300070.8642-100000@eduserv.rug.ac.be>
Message-ID: <Pine.LNX.4.21.0111281214550.613-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

It can be NULL for kernel threads which do not have a user address
space. Nevertheless, their tsk->active_mm would not be NULL but point to
some process' address space.

The point of  having active_mm is to minimize TLB flushes on switching
address spaces when the task is scheduled out.

Regards,
Tigran

On Wed, 28 Nov 2001, Frank Cornelis wrote:

> Hey,
> 
> I found in some code checks for task_struct.mm being NULL.
> When can task_struct.mm of a process be NULL except right before the
> process-kill?
> 
> Frank.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

