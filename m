Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310434AbSCXQl3>; Sun, 24 Mar 2002 11:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSCXQlT>; Sun, 24 Mar 2002 11:41:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21775 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310372AbSCXQlC>; Sun, 24 Mar 2002 11:41:02 -0500
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
To: andihartmann@freenet.de (andreas)
Date: Sun, 24 Mar 2002 16:57:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <3C9DC1F5.6010508@athlon.maya.org> from "andreas" at Mar 24, 2002 01:09:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pBJE-0006hU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got a basic question:
> Would it be possible to kill only the process which consumes the most 
> memory in the last delta t?
> Or does somebody have a better idea?

At the point you hit OOM every possible heuristic is simply handwaving that
will work for a subset of the user base. Fix the real problem and it goes
away. My box doesn't OOM, the worst case (which I've never seen happen) is
a task being killed by a stack growth failing to get memory.
