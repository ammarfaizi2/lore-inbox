Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWB0AS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWB0AS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWB0AS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:18:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:17345 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751455AbWB0AS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:18:26 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1140994951.24141.204.camel@mindpipe>
References: <1140917787.24141.78.camel@mindpipe>
	 <1140945232.2934.0.camel@laptopd505.fenrus.org>
	 <1140982513.24141.118.camel@mindpipe>
	 <1140988293.3982.8.camel@localhost.localdomain>
	 <1140989489.24141.159.camel@mindpipe>
	 <1140994427.3982.11.camel@localhost.localdomain>
	 <1140994951.24141.204.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 11:18:19 +1100
Message-Id: <1140999499.3982.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 18:02 -0500, Lee Revell wrote:
> On Mon, 2006-02-27 at 09:53 +1100, Benjamin Herrenschmidt wrote:
> > Well... as soon as a 3d window appears, the server starts switching
> > all the time. there might be some spin loop in there remaining... 
> 
> But if the only lock taken in the radeon driver is the BKL, the
> SCHED_NORMAL X server should not be able to delay a SCHED_FIFO process
> right?

If you have preempt enabled, I suppose .... can we preempt with the BKL
nowadays ?



