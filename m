Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbRFMJds>; Wed, 13 Jun 2001 05:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFMJdh>; Wed, 13 Jun 2001 05:33:37 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S262170AbRFMJd0>;
	Wed, 13 Jun 2001 05:33:26 -0400
Date: Tue, 12 Jun 2001 16:06:44 +0000
From: Pavel Machek <pavel@suse.cz>
To: stas.orel@mailcity.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] do proper cleanups before requesting irq
Message-ID: <20010612160643.B33@toy.ucw.cz>
In-Reply-To: <01061202405801.06615@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <01061202405801.06615@localhost.localdomain>; from stas_orel@yahoo.com on Tue, Jun 12, 2001 at 03:53:57AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The problem is that there are comparisons of pointers to task_struct when
> deciding if the task is alive. If one task dies and other one starts, it is
> possible (is it?) that the task structure of the newly created task resides
> at the very address where was the dead one's, so comparing pointers is not
> reliable. This patch changes it to comparisons of task's pids.
> Can anyone, please, atleast tell me if this patch is correct?

it might be better but it is not correct. pids are reused, too
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

