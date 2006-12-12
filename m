Return-Path: <linux-kernel-owner+w=401wt.eu-S1751495AbWLLQMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWLLQMR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWLLQMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:12:17 -0500
Received: from pat.uio.no ([129.240.10.15]:60251 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbWLLQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:12:17 -0500
Subject: Re: hi, should these code is a problem in nfs system clnt.c?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Staubach <staubach@redhat.com>
Cc: linuxer linuxer <tangzt@yahoo.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, alan@redhat.com
In-Reply-To: <457EB5E6.9060207@redhat.com>
References: <319714.29242.qm@web36002.mail.mud.yahoo.com>
	 <457EB5E6.9060207@redhat.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 11:11:45 -0500
Message-Id: <1165939906.5788.36.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.325, required 12,
	autolearn=disabled, AWL 1.54, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 09:00 -0500, Peter Staubach wrote:
> linuxer linuxer wrote:
> > Hi, everyone: 
> >     I am a newbie, if my question waste your time, I
> > am sorry for that. 
> >
> >     In clnt.c file ,call_timeout function:    
> >     I suggest the code that judge whether the network
> > link status is down should be added, won't they? 
> >     I tested it with one Ethernet netcard.
> >
> >   
> 
> This would not be a good idea.  What happens if the name of the
> interface used on the system is not "eth0"?
> 
> Also, IP packets can be routed out of any available interface,
> so just because one interface (eth0) is down, doesn't mean
> that the entire system is networkless.

Right. Besides, it is also an obvious layering violation. Idea NAKed.

Trond

