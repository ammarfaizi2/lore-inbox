Return-Path: <linux-kernel-owner+w=401wt.eu-S1755046AbXACJhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbXACJhG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 04:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbXACJhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 04:37:06 -0500
Received: from brick.kernel.dk ([62.242.22.158]:7712 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471AbXACJhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 04:37:03 -0500
Date: Wed, 3 Jan 2007 10:39:51 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Tomas Carnecky <tom@dbservice.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       akpm@osdl.org
Subject: Re: [PATCH] 3/4 qrcu: add documentation
Message-ID: <20070103093951.GM11203@kernel.dk>
References: <11678105083001-git-send-email-jens.axboe@oracle.com> <20070103083123.GJ11203@kernel.dk> <459B7766.5050404@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459B7766.5050404@dbservice.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03 2007, Tomas Carnecky wrote:
> Jens Axboe wrote:
> > diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.txt
> > index f4dffad..36d6185 100644
> > --- a/Documentation/RCU/checklist.txt
> > +++ b/Documentation/RCU/checklist.txt
> > @@ -259,3 +259,16 @@ over a rather long period of time, but improvements are always welcome!
> >  
> >  	Note that, rcu_assign_pointer() and rcu_dereference() relate to
> >  	SRCU just as they do to other forms of RCU.
> > +
> > +14.	QRCU is very similar to SRCU, but features very fast grace-period
> > +	processing at the expense of heavier-weight read-side operations.
> > +	The correspondance between QRCU and SRCU is as follows:
> > +
> > +		QRCU			SRCU
> > +
> > +		struct qrcu_struct	struct srcu_struct
> > +		init_qrcu_struct()	init_srcu_struct()
> > +		cleanup_qrcu_struct()	cleanup_srcu_struct()
> > +		qrcu_read_lock()	srcu_read_lock()
> > +		qrcu_read-unlock()	srcu_read_unlock()
> 
> A small typo: qrcu_read_unlock()

Indeed, thanks, I'll update the repo.

-- 
Jens Axboe

