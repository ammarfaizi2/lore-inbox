Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318041AbSGRMpW>; Thu, 18 Jul 2002 08:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318042AbSGRMpW>; Thu, 18 Jul 2002 08:45:22 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:37857 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S318041AbSGRMpV>; Thu, 18 Jul 2002 08:45:21 -0400
Date: Thu, 18 Jul 2002 14:16:59 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux m68k <linux-m68k@lists.linux-m68k.org>
Subject: shm_close BUG, 2.4.18
Message-ID: <20020718141659.A218@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I got postmaster->sys_exit->do_exit->mmput->exit_mmap->shm_close->BUG->Oops
Is this a known issue?

Not sure yet why postmaster (postgresql-server-7.1.3) wanted to exit and 
it had nothing to do at that time. It appears some c++ compilation died 
with a SEGV at the same time although nothing else indicates an oom
(I have verified the compilation had enough swap).

Richard
