Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273382AbTG3TaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273358AbTG3TaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:30:05 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:58885 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S273357AbTG3T2O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:28:14 -0400
Date: Wed, 30 Jul 2003 21:28:32 +0200
From: aradorlinux@yahoo.es
To: Con Kolivas <kernel@kolivas.org>
Cc: miller@techsource.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] O10int for interactivity
Message-Id: <20030730212832.22e065ad.aradorlinux@yahoo.es>
In-Reply-To: <200307301136.06396.kernel@kolivas.org>
References: <200307280112.16043.kernel@kolivas.org>
	<200307300035.01354.kernel@kolivas.org>
	<20030730031616.3ed14362.diegocg@teleline.es>
	<200307301136.06396.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[changing email address; several hosts block mail from *@teleline/terra.es;
which is good if they're fighting against spam]
El Wed, 30 Jul 2003 11:36:06 +1000 Con Kolivas <kernel@kolivas.org> escribió:

> The logic is in the difference between the dynamic and the static priority to 
> determine if a task is interactive. 
> current->static_prio - current->prio
> will give you a number of -5 to +5, with +5 being a good bonus and vice versa.
> however you need to ensure that the value you are fiddling with in the i/o 
> scheduler is actually due to the current process[1]

I think current really is the process submitting the request; at least in the
same function we've this:

        if (rq_data_dir(arq->request) == READ
                        || current->flags&PF_SYNCWRITE)

Which would be wrong if current isn't the process submitting the request.


Diego Calleja
