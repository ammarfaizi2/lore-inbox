Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277654AbRJMJvW>; Sat, 13 Oct 2001 05:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277684AbRJMJvM>; Sat, 13 Oct 2001 05:51:12 -0400
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:688 "EHLO
	stud.fbi.fh-darmstadt.de") by vger.kernel.org with ESMTP
	id <S277654AbRJMJvB>; Sat, 13 Oct 2001 05:51:01 -0400
Date: Sat, 13 Oct 2001 11:48:11 +0200 (CEST)
From: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: crc32 cleanups
In-Reply-To: <Pine.LNX.4.33.0110121340140.17295-100000@lists.us.dell.com>
Message-ID: <Pine.LNX.4.30.0110131131200.32076-100000@stud.fbi.fh-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this summarizes the problems with the crc code

1. Should the crc code be included in the kernel generally ?
2. If not - should the user or the driver modules change the behaviour of
the kernel build process ?
3. How do we provide crc functions for modules not included in the main
kernel tree ?
4. Should we use precompiled tables (bigger kernel) or use more compex
(slower) algorithms ?

I think the code should generally be included in the kernel - we can add
somewhere an option like "Remove crc code from kernel if not used" marked
as "dangerous". So the user can force removal if he is sure, he will never
use the code. The drivers included in the kernel may still enable the
code, if needed, but extern drivers won't work.

To safe space or gain performance we should add a select option next to
the "remove crc" one ("Optimize crc code for space/performance")

Comments

Jan-Marek Glogowski

