Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbSI2UIY>; Sun, 29 Sep 2002 16:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbSI2UIY>; Sun, 29 Sep 2002 16:08:24 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:21259 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261764AbSI2UIX>; Sun, 29 Sep 2002 16:08:23 -0400
Date: Sun, 29 Sep 2002 21:13:32 +0100
From: John Levon <levon@movementarian.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] break out task_struct from sched.h
Message-ID: <20020929201331.GA90617@compsoc.man.ac.uk>
References: <Pine.LNX.4.33.0209292137550.7800-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209292137550.7800-100000@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 09:50:48PM +0200, Tim Schmielau wrote:

> This patch separates struct task_struct from <linux/sched.h> to 
> a new header <linux/task_struct.h>, so that dereferencing 'current'
> doesn't require to #include <linux/sched.h> and all of the 138 files it 
> drags in.

It seems a bit odd to me that you /only/ split out task_struct but none
of the simple helpers (for_each_process(), task_lock,
set_task_state etc.). I'd prefer a task.h personally, many of these can
be placed without further burdening the include nest.

It'd certainly be nice to see sched.h properly cleaned up at some point
(request_irq() ??? d_path() ???)

regards
john

