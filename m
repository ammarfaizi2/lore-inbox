Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135670AbREFMus>; Sun, 6 May 2001 08:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135669AbREFMui>; Sun, 6 May 2001 08:50:38 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:21403 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S135663AbREFMub>; Sun, 6 May 2001 08:50:31 -0400
From: Stefan Hoffmeister <lkml.2001@Econos.de>
To: linux-kernel@vger.kernel.org
Subject: ptrace, debugging threads, zombies
Date: Sun, 06 May 2001 14:49:09 +0200
Organization: Econos
Message-ID: <2vhaft001udd483dlctgnn8c4t674f48lc@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

in

  http://boudicca.tux.org/hypermail/linux-kernel/2000week51/0423.html

Mark Kettenis writes

<quote>
However, the "zombie problem" is caused by the way ptrace() interacts 
with clone()/exit()/wait(), which I consider to be a kernel bug. 
</quote>

What apparently happens is that even though a thread has been terminated,
the debugger is never notified - and that causes zombies, and that in turn
causes out-of-resources problems. 

Is there any hope of this getting fixed in the 2.4 or the 2.2 series? The
patch supplied by Mark Kettenis AFAICS has neither been applied to 2.2.19
nor to 2.4.4.

TIA,
Stefan
