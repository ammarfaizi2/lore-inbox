Return-Path: <linux-kernel-owner+w=401wt.eu-S932600AbXAJISG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXAJISG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 03:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbXAJISF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 03:18:05 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:38967 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbXAJISE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 03:18:04 -0500
Message-ID: <45A4A102.6050006@bull.net>
Date: Wed, 10 Jan 2007 09:17:06 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jakub Jelinek <jakub@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
       =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 3/4] futex_requeue_pi optimization
References: <45A3B330.9000104@bull.net> <45A3C0CF.4020802@bull.net> <45A3C3F1.6020305@redhat.com>
In-Reply-To: <45A3C3F1.6020305@redhat.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 09:26:08,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/01/2007 09:26:09,
	Serialize complete at 10/01/2007 09:26:09
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote :
> 
> So, this patch implements requeuing from a non-PI futex to a PI futex?

Yes.

> That's the bare minimum needed.  What about PI to PI?

I may miss something, but I don't think there is a need for that.

Currently, futex_requeue is (only) used in pthread_cond_broadcast to requeue 
some threads from an internal futex (futex1) to another futex (futex2, which is 
the futex behind the cond_mutex)

futex1 does not need to be a PI-futex, I think.

-- 
Pierre
