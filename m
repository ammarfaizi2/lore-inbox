Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267918AbUHET46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267918AbUHET46 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267932AbUHET46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:56:58 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:33425 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S267918AbUHET4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:56:38 -0400
From: Alessandro Amici <alexamici@fastwebnet.it>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cputime (1/6): move call to update_process_times.
Date: Thu, 5 Aug 2004 21:57:47 +0200
User-Agent: KMail/1.6.2
References: <20040805180335.GB9240@mschwid3.boeblingen.de.ibm.com>
In-Reply-To: <20040805180335.GB9240@mschwid3.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408052157.47603.alexamici@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

On Thursday 05 August 2004 20:03, Martin Schwidefsky wrote:
> For non-smp kernels the call to update_process_times is done
> in the do_timer function. It is more consistent with smp kernels
> to move this call to the architecture file which calls do_timer.

I don't have enough knowledge to comment on the merit of the move to 
architecture files, but the proliferation of #ifndef CONFIG_SMP looks really 
ugly.

Wouldn't it be possible to move the #ifndef into sched.h?

--
Alessandro
