Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269829AbTGKIk4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269831AbTGKIk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:40:56 -0400
Received: from aneto.able.es ([212.97.163.22]:21720 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S269829AbTGKIkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:40:55 -0400
Date: Fri, 11 Jul 2003 10:55:35 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-pre4] hangs on init start with 'block clobbered'
Message-ID: <20030711085535.GA2545@werewolf.able.es>
References: <20030711013244.GA2392@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030711013244.GA2392@werewolf.able.es>; from jamagallon@able.es on Fri, Jul 11, 2003 at 03:32:44 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.11, J.A. Magallon wrote:
> Hi all...
> 
> Plain 2.4.22-pre4 hangs when tries to launch init. booting to runlevel 5 I get:
> 
> INIT: version 2.85 booting
> INIT: Entering runlevel 5
> 
> malloc: block on free list clobbered
> Stopping myself...Kernel panic: Attempted to kill init!
> 
> If i try to boot in singleuser (runlevel 1), the booting process just
> stops after the version line.
> 
>

One more clue: I booted with init=/bin/bash. It got to the bash prompt.
I did an 'ls' (I was at /). It showed all the entries _DUPLICATED_ 
( two /bin, two /boot ....), and then panic'ed again.
So perhaps it is some code in the fs layer what is miscompiled...
The system hangs as soon as I touch the disk.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
