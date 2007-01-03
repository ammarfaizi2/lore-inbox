Return-Path: <linux-kernel-owner+w=401wt.eu-S1750791AbXACOfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXACOfk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbXACOfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:35:40 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:52887 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbXACOfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:35:39 -0500
Message-ID: <459BBF15.5070505@bull.net>
Date: Wed, 03 Jan 2007 15:35:01 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       =?ISO-8859-1?Q?S=E9bastien?= =?ISO-8859-1?Q?_Dugu=E9?= 
	<sebastien.dugue@bull.net>,
       Ulrich Drepper <drepper@redhat.com>, Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH 2.6.19.1-rt15][RFC] - futex_requeue_pi implementation
 (requeue from futex1 to PI-futex2)
References: <459BA267.1020706@bull.net> <20070103123536.GA9088@elte.hu>
In-Reply-To: <20070103123536.GA9088@elte.hu>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/01/2007 15:43:34,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/01/2007 15:43:37,
	Serialize complete at 03/01/2007 15:43:37
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar a écrit :
> 
> looks good to me in principle. The size of the patch is scary - is there 
> really no simpler way? 

Humf, in fact, for the 64-bit part, I've followed the rule of the existing 
64-bit code in futex.c, which consists of duplicating all the functions which 
can not be kept common, and add a suffix 64 to all duplicated functions.
Perhaps I missed something ?

> Also, could you send me a patch against a 
> 20-rc3-rt0-ish kernel so that i can stick this into -rt for testing?
> 
Ok, will do that.

Thanks,

-- 
Pierre Peiffer
