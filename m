Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbSI2VBo>; Sun, 29 Sep 2002 17:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbSI2VBo>; Sun, 29 Sep 2002 17:01:44 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37391
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261800AbSI2VBo>; Sun, 29 Sep 2002 17:01:44 -0400
Subject: Re: [PATCH] break out task_struct from sched.h
From: Robert Love <rml@tech9.net>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: John Levon <levon@movementarian.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0209292242470.7949-100000@gans.physik3.uni-rostock.de>
References: <Pine.LNX.4.33.0209292242470.7949-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain
Organization: 
Message-Id: <1033333589.22056.1381.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 29 Sep 2002 17:06:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 17:00, Tim Schmielau wrote:

> You're right.
> I had the vague hope that by separating type definitions only
> some future cleanup might help us to cut down on the number of
> headers included by task_struct.h (currently 60).
> Introducing a full-blown task.h looks like killing sched.h completely

I like this: introduce a tasks.h to separate the task_struct and any
helper macros that depend on it.

We can keep sched.h though - but just for scheduler stuff from sched.c. 
We need a place to put the prototypes, inlines, and defines from sched.c
and sched.h is the cleanest place.

It is the other stuff (task_struct most importantly, as you point out)
that needs to go.

> Killing ~600 #include <linux/sched.h> lines however seemed enough for a 
> first round, so I left this for later iterations.

Indeed, good job.

	Robert Love

