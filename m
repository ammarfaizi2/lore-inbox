Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUEDEoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUEDEoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 00:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbUEDEoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 00:44:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:2983 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264231AbUEDEox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 00:44:53 -0400
Subject: Re: workqueue and pending
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mixxel@cs.auc.dk, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040503211540.052848a1.akpm@osdl.org>
References: <40962F75.8000200@cs.auc.dk>
	 <20040503162719.54fb7020.akpm@osdl.org> <1083639081.20092.294.camel@gaston>
	 <20040503201616.6f3b8700.akpm@osdl.org> <1083642950.29596.299.camel@gaston>
	 <20040503211540.052848a1.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1083645686.20091.301.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 04 May 2004 14:41:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-04 at 14:15, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > It's probably still good to precise explicitely in the comments
> >  that upon return of cancel_delayed_work(), the work queue might
> >  still be pending and that a flush and whoever called this may
> >  still need a flush_scheduled_work() or flush_workqueue() (provided
> >  it's running in a context where that can sleep)
> 
> That function was originally written by a comment fetishist.

Heh, I should have looked at the code =P

Ben.


