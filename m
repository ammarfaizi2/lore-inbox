Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbWECQZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbWECQZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWECQZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:25:28 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:37285 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965236AbWECQZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:25:27 -0400
Date: Wed, 3 May 2006 18:25:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Juho Saarikko <juhos@mbnet.fi>
cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] 2.6.16-ck9
In-Reply-To: <1146603461.5213.32.camel@a88-112-69-25.elisa-laajakaista.fi>
Message-ID: <Pine.LNX.4.61.0605031821140.13546@yvahk01.tjqt.qr>
References: <200605022338.20534.kernel@kolivas.org>
 <1146603461.5213.32.camel@a88-112-69-25.elisa-laajakaista.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I tried to run SetiAtHome at IDLEPRIO, but it competes equally with a
>while(1); loop run at nice 19. I'm starting to wonder if there isn't
>some kind of bug in the kernel which results in a program returning from
>a system call with an in-kernel semaphore held. After all, according to
>top, SetiAtHome consumes over 90% CPU, and the system consumes only
>about 1%, so it can't be making system calls all the time either.

SAH does make very few system calls in relation to its computing, in fact. 
[It's a guess, not a proven answer.] The boinc supervisor process is mostly 
the syscall, filesystem and networking part.

>This pattern just keeps on repeating, endlessly. Occasionally it also
>has
>
>kill(5432, SIG_0)                       = 0
>
>attached to it. 5432 is the parent process, the FAH502-Linux.exe.

You don't use boinc?

>There is something very strange going on here...


Jan Engelhardt
-- 
