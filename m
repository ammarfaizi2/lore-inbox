Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281340AbRKLIg3>; Mon, 12 Nov 2001 03:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281343AbRKLIgT>; Mon, 12 Nov 2001 03:36:19 -0500
Received: from wallext.webflex.nl ([212.115.150.250]:38832 "EHLO
	palm.webflex.nl") by vger.kernel.org with ESMTP id <S281340AbRKLIgK>;
	Mon, 12 Nov 2001 03:36:10 -0500
Message-ID: <XFMail.20011112093536.mathijs@knoware.nl>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E163CLH-0000J4-00@baldrick>
Date: Mon, 12 Nov 2001 09:35:36 +0100 (CET)
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: tasklets and finalization
Cc: linux-kernel@vger.kernel.org, Mathijs Mohlmann <mathijs@knoware.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Nov-2001 Duncan Sands wrote:
> ...
> tasklet_schedule(&my_tasklet);
> tasklet_kill(&my_tasklet);
> ...
> 
> Since (as far as I can see) there is no way the
> tasklet will run before calling tasklet_kill, this
> should just kill any pending tasklets.

cpu#1           cpu#2
tasklet_schedule
                tasklet_schedule
run tasklet
                tasklet_kill
                loop


-- 
        me
