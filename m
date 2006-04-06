Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWDFDeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWDFDeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWDFDeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:34:08 -0400
Received: from dvhart.com ([64.146.134.43]:37830 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751354AbWDFDeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:34:05 -0400
From: Darren Hart <darren@dvhart.com>
To: "Christopher Friesen" <cfriesen@nortel.com>
Subject: Re: help? converting to single global prio_array in scheduler, ran into snag
User-Agent: KMail/1.8.3
References: <4433F636.3090705@nortel.com> <4433FCF5.7080604@nortel.com>
In-Reply-To: <4433FCF5.7080604@nortel.com>
MIME-Version: 1.0
Content-Disposition: inline
Date: Wed, 5 Apr 2006 20:34:02 -0700
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604052034.02962.darren@dvhart.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 April 2006 10:23, you wrote:
> I should clarify that CKRM is currently disabled--I'm trying to get the
> vanilla scheduler working first before changing the CKRM stuff to use
> per-class prio arrays rather than per-class per-cpu ones.
>

First thing that comes to mind, did you look for every place that accesses the 
arrays via the rq->lock and make it use the new global array_lock?  It would 
help if you would post your initial patch for review (designating it as RFC, 
not intended for inclusion).

(Chris, sorry for the duplicate, forgot to cc the list first time around)

Thanks,

--Darren
