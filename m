Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283018AbRK1MXq>; Wed, 28 Nov 2001 07:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283011AbRK1MXg>; Wed, 28 Nov 2001 07:23:36 -0500
Received: from ns.suse.de ([213.95.15.193]:3599 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283017AbRK1MXW>;
	Wed, 28 Nov 2001 07:23:22 -0500
To: Frank Cornelis <Frank.Cornelis@rug.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: task_struct.mm == NULL
In-Reply-To: <Pine.GSO.4.31.0111281300070.8642-100000@eduserv.rug.ac.be.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Nov 2001 13:23:20 +0100
In-Reply-To: Frank Cornelis's message of "28 Nov 2001 13:09:45 +0100"
Message-ID: <p734rnfrsnb.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Cornelis <Frank.Cornelis@rug.ac.be> writes:

> Hey,
> 
> I found in some code checks for task_struct.mm being NULL.
> When can task_struct.mm of a process be NULL except right before the
> process-kill?

For kernel threads that run in lazy-mm mode. It allows a much cheaper context
switch into kernel threads.

-Andi
