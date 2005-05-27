Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVE0IHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVE0IHy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVE0IHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:07:54 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:27530 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261975AbVE0IHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:07:39 -0400
Date: Fri, 27 May 2005 10:07:29 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>
Cc: Simon Derr <Simon.Derr@bull.net>, akpm@osdl.org, dino@in.ibm.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
In-Reply-To: <20050526164018.4880ecac.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0505271000410.11050@openx3.frec.bull.fr>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
 <Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr> <20050526164018.4880ecac.pj@sgi.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/05/2005 10:18:26,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/05/2005 10:18:29,
	Serialize complete at 27/05/2005 10:18:29
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005, Paul Jackson wrote:

> Would it make sense, Simon, to recommend to Andrew that
> he take the simple patch I submitted yesterday for this
> now, since it avoids a kernel crash and the risk of other
> uglies?
> 
> Then, when we understand that improved scalability is needed,
> and we have agreed on a solution to that, offer up a second
> patch?
> 
Of course !



> > I feel like this 'scaling problem' still exists even with:
> Can you back this feeling with numbers, with real measurements?

I don't.
My point is only that if you think there is a scaling problem in 
taking cpuset_sem for each call to cpuset_exit(), that scaling problem 
won't disappear by taking cpuset_sem only for 'notify_on_remove' cpusets, 
as such cpusets might exist over the whole system.

	Simon.

