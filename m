Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVAMVOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVAMVOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVAMVLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:11:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261519AbVAMVJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:09:07 -0500
Date: Thu, 13 Jan 2005 22:07:51 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Lee Revell <rlrevell@joe-job.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050113210750.GA22208@devserv.devel.redhat.com>
References: <20050111214152.GA17943@devserv.devel.redhat.com> <200501112251.j0BMp9iZ006964@localhost.localdomain> <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us> <20050112074906.GB5735@devserv.devel.redhat.com> <87oefuma3c.fsf@sulphur.joq.us> <20050113072802.GB13195@devserv.devel.redhat.com> <878y6x9h2d.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878y6x9h2d.fsf@sulphur.joq.us>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 03:04:26PM -0600, Jack O'Quin wrote:
> 
> (Probably, this simplistic analysis misses some other, more subtle,
> factors.)

I think you can do nasty things to the locks held by those threads too

> 
> RT threads should not do FS writes of their own.  But, a badly broken
> or malicious one could, I suppose.  So, that might provide a mechanism
> for losing more data than usual.  Is that what you had in mind?

basically yes.
note that "FS writes" can come from various things, including library calls
made and such. But I think you got my point; even though it might seem a bit
theoretical it sure is unpleasant.
