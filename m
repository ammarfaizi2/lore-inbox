Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVDAFbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVDAFbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVDAFan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:30:43 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:34520 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262638AbVDAF3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:29:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IHEedDM5yaZEvxU6/Tp1hwS/MRHIY27aiTQ1m6sCgijbLyFye0p05/UjogUEzbu11FF8kokVyumbmY0vxqoLDHhFr8XQFK/m7mrT/Lq9yjFRtxoImhHMHSaIFlcH+fbDLgwSN+98oOUJEXI80gkn8VbLRCbeb0FclSMCBCnCd8Y=
Date: Fri, 1 Apr 2005 14:29:42 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 09/13] scsi: in scsi_prep_fn(), remove bogus comments & clean up
Message-ID: <20050401052942.GH11318@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.B562915C@htj.dyndns.org> <1112292140.5619.26.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112292140.5619.26.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

On Thu, Mar 31, 2005 at 12:02:20PM -0600, James Bottomley wrote:
> On Thu, 2005-03-31 at 18:08 +0900, Tejun Heo wrote:
> > -	 * come up when there is a medium error.  We have to treat
> > -	 * these two cases differently.  We differentiate by looking
> > -	 * at request->cmd, as this tells us the real story.
> > +	 * come up when there is a medium error.
> 
> This comment isn't wrong.  That's exactly what this piece of code:
> 
> 		if (sreq->sr_magic == SCSI_REQ_MAGIC) {
> 
> is all about ... that's how it distinguishes between the two cases.
> 
> The comment is misleading --- what it actually should say is that req-
> >special has different contents depending upon the two cases, so
> rephrasing it to be more accurate would be helpful.

 Yes, it was misleading, even more so with previous REQ_SPECIAL
patches.  I'll rewrite the comment once we resolve the REQ_SPECIAL
issue.

 Thanks.

-- 
tejun

