Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293052AbSBWAPm>; Fri, 22 Feb 2002 19:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293053AbSBWAPc>; Fri, 22 Feb 2002 19:15:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54281 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293052AbSBWAPZ>; Fri, 22 Feb 2002 19:15:25 -0500
Subject: Re: [PATCH] 2.4.18-rc2 Fix for get_pid hang
To: plars@austin.ibm.com (Paul Larson)
Date: Sat, 23 Feb 2002 00:29:47 +0000 (GMT)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1014416988.12007.461.camel@plars.austin.ibm.com> from "Paul Larson" at Feb 22, 2002 04:29:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16eQ4R-0003cZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This was made against 2.4.18-rc2 but applies cleanly against
> 2.4.18-rc4.  This is a fix for a problem where if we run out of
> available pids, get_pid will hang the system while it searches through
> the tasks for an available pid forever.

Wouldn't it be a much cleaner patch to limit the maximum number of processes
to less than the number of pids available. You seem to be fixing a non
problem by adding branches to the innards of a loop.


