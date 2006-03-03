Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWCCJQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWCCJQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWCCJQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:16:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50563 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932115AbWCCJQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:16:24 -0500
Subject: Re: [PATCH 1/15] EDAC: switch to kthread_ API
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Peterson <dsp@llnl.gov>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       hch@lst.de
In-Reply-To: <20060302183035.6a15a1fc.akpm@osdl.org>
References: <200603021747.47515.dsp@llnl.gov>
	 <20060302183035.6a15a1fc.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 10:16:18 +0100
Message-Id: <1141377378.2883.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 18:30 -0800, Andrew Morton wrote:
> Dave Peterson <dsp@llnl.gov> wrote:
> >
> >   		schedule_timeout((HZ * poll_msec) / 1000);
> >   		try_to_freeze();
> >  +		__set_current_state(TASK_RUNNING);
> 
> schedule() and schedule_timeout*() always return in state TASK_RUNNING, so
> I'll take that out of there.
> 
> We might as well use schedule_timeout_interruptible(), too.  As a bonus, we
> get to delete that spelling mistake ;)


or even msleep variant ;)

