Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTFFTAP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTFFTAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:00:15 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:21949 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262192AbTFFTAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:00:13 -0400
Date: Fri, 6 Jun 2003 21:13:46 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.70-bk11 zlib cleanup #3 Z_NULL
Message-ID: <20030606191346.GF10487@wohnheim.fh-wedel.de>
References: <20030606183920.GC10487@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0306061151420.30453-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0306061151420.30453-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 June 2003 11:54:45 -0700, Linus Torvalds wrote:
> On Fri, 6 Jun 2003, Jörn Engel wrote:
> > 
> > How do you feel about "if (z->state->blocks != NULL)"?  Remove the
> > pointless !=NULL or keep it?
> 
> I don't mind it, but it doesn't buy much.
> 
> It's actually in some other cases where I think there is a readability 
> issue, ie in more complex conditionals I personally prefer the simpler 
> cersion, ie I much prefer something like
> 
> 	if (ptr && ptr->ops && ptr->ops->shutdown)
> 		ptr->ops->shutdown(ptr, xxxx);
> 
> over the pointless NULL-masturbation in something like
> 
> 	if (ptr != NULL && ptr->ops != NULL && ptr->ops->shutdown != NULL)
> 		ptr->ops->shutdown(ptr, xxxx)
> 
> which I just is much less readable than the simple version.

Good example.  The ones I found in the zlib are not that bad and I am
lazy, so I'll leave them for someone else.

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
