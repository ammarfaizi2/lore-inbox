Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288593AbSA0UEN>; Sun, 27 Jan 2002 15:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288544AbSA0UDx>; Sun, 27 Jan 2002 15:03:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49673 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288548AbSA0UDu>; Sun, 27 Jan 2002 15:03:50 -0500
Subject: Re: [PATCH] 2.4.17 pthread support for SEM_UNDO in semop()
To: oliendm@us.ibm.com (Dave Olien)
Date: Sun, 27 Jan 2002 20:16:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <200201221834.g0MIY9s08359@eng2.beaverton.ibm.com> from "Dave Olien" at Jan 22, 2002 10:34:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Uvj0-0002UK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* For now, assume that if ALL clone flags are set, then
> + * we must be creating a POSIX thread, and we want undo lists
> + * to be shared among all the threads in that thread group.

Not a good idea. There are large numbers of cases where the threads being
created a real linux ones not posix abortions.

Alan
