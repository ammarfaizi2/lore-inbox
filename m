Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVKOTAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVKOTAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVKOTAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:00:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:65451 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964992AbVKOTAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:00:42 -0500
Date: Tue, 15 Nov 2005 13:00:30 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051115190030.GA16790@sergelap.austin.ibm.com>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115010155.GA3792@IBM-BWN8ZTBWAO1> <20051114175140.06c5493a.pj@sgi.com> <20051115022931.GB6343@sergelap.austin.ibm.com> <20051114193715.1dd80786.pj@sgi.com> <20051115051501.GA3252@IBM-BWN8ZTBWAO1> <20051114223513.3145db39.pj@sgi.com> <20051115081100.GA2488@IBM-BWN8ZTBWAO1> <20051115010624.2ca9237d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115010624.2ca9237d.pj@sgi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Jackson (pj@sgi.com):
> An additional per-task attribute, set by a batch manager typically
> when it starts a job on a checkpointable, restartable, movable
> "virtual server" connects the job parent task, and hence all its
> descendents in that job, with a named kernel object that has among its
> attributes a pid range.  When fork is handing out new pids, it honors
> that pid range.  User level code, in the batch manager or system
> administration layer manages a set of these named virtual servers,
> including assigning pid ranges to them, and puts what is usually the
> same such configuration on each server in the farm.

I guess the one thing I really don't see supported here (apart from the
system/laptop joins the network after spawning a job which has been
mentioned) is restarting multiple simulatenous instances of a single
checkpoint.  In the pidspace approach, each restarted instance would
have a different pidspace id, but use the same vpids.  In the
preallocation scheme, only one pid has been reserved at checkpoint for
each process instance.

Is there a simple way to solve this?  (And how valid a concern is
this?  :)

Other than that, I guess your approach is growing on me...

-serge
