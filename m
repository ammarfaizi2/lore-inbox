Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWEVDJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWEVDJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 23:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWEVDJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 23:09:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:39396 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964999AbWEVDJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 23:09:15 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200605221243.54100.kernel@kolivas.org>
References: <4470CC8F.9030706@keyaccess.nl>
	 <200605221033.49153.kernel@kolivas.org> <1148264043.7643.15.camel@homer>
	 <200605221243.54100.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 22 May 2006 05:10:26 +0200
Message-Id: <1148267426.21765.15.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 12:43 +1000, Con Kolivas wrote:
> On Monday 22 May 2006 12:14, Mike Galbraith wrote:
> > In my tree, I don't use the expired array for anything except batch
> > tasks any more for this very reason. The latency just hurts too bad.
> 
> So it's turning your tree into a single priority array design effectively just 
> like staircase ;) ?

Similar I suppose.  I still do have dual arrays though, because it's an
almost free way to deal with batch tasks (and is now named accordingly).

I also still use sleep_avg, but I keep it sane, and with the full
dynamic spread instead of gravitating to either full or empty, and I
monitor for cpu hungry tasks, and let them climb the ladder to where the
action is.  That way, it retains the pleasant interactivity of the
current design, yet is absolutely starvation proof.

	-Mike

