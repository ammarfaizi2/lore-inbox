Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318890AbSIIUsb>; Mon, 9 Sep 2002 16:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318891AbSIIUsb>; Mon, 9 Sep 2002 16:48:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30741 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318890AbSIIUs3>; Mon, 9 Sep 2002 16:48:29 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209092051.g89KpVg05996@devserv.devel.redhat.com>
Subject: Re: 2.4-pre5[{-}xyz]: 4 machines, feedback only
To: bunk@fs.tum.de (Adrian Bunk)
Date: Mon, 9 Sep 2002 16:51:31 -0400 (EDT)
Cc: vanonim@bluewin.ch (Mario Vanoni), alan@redhat.com (Alan Cox),
       andre@linux-ide.org (Andre Hedrick),
       linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <Pine.NEB.4.44.0209092234120.11139-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Sep 09, 2002 10:41:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ide-proc.c is compiled into idedriver.o even if no IDE support is compiled
> into the kernel. That isn't new. The problem that causes these undefined

Thts fine

> references is that in -ac4 some functions that use functions from other
> ide files (which aren't compiled when building a kernel without IDE
> support) are no longer static (because they are now exported to modules).

idedriver.o  shouldnt be getting into a kernel without IDE. Thats the
real problem
