Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270501AbTHQTNl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270505AbTHQTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:13:41 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:2317 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S270501AbTHQTNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:13:38 -0400
Date: Sun, 17 Aug 2003 21:14:24 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Jeff Garzik <jgarzik@pobox.com>
cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5 IrDA] vlsi driver update
In-Reply-To: <3F3FB0C4.3000004@pobox.com>
Message-ID: <Pine.LNX.4.44.0308172017160.1469-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003, Jeff Garzik wrote:

> Jean Tourrilhes wrote:
> > ir2603_vlsi-05.diff :
> > ~~~~~~~~~~~~~~~~~~~
> > 		<Patch from Martin Diehl>
> 
> this patch needs splitting up

Ok, maybe this is your answer to what I've pointed out in PM some days 
ago. But let me repeat just in case this was lost somehow.

During 2 months of repeatedly resending the patch the size was never an 
issue - just silently dropped and then asked for resubmit.

Due to 3rd party changes getting applied it is practically impossible to 
maintain this splitted into several parts over such a time.

Splitting it now - particularly after having it merged with such changes 
over time - would cause major work. This stuff was on the irda list and on 
Jean's page for several months without complains. In fact it would be even 
more important to get the whole thing back into 2.4.

There are not many users with this hardware so even in the unlikely case 
where it would break more than it fixes there are not many people 
involved. We are talking about a patch against a single driver which I do 
maintain actively.

I completely understand several smaller patches would be prefereable, but 
given the history of the patch let me ask again whether it could be 
applied to 2.6 in its current state. If not, I'd try to find some 
resources to break it down for 2.6 - but as this will take some time and 
I'm sure there will be other changes (both trivial an api-wise) meanwhile 
I think I'll better wait until things settle around 2.6.5 or so...

And what are your suggestions wrt. to 2.4. For the backport, splitting it 
up is absolutely impossible because it's merely a complete rewrite. The 
options I see are (order of personal preference):

1) apply single big patch, basically replacing the code
2) back out the existing driver and put in a new one resulting in the same 
   code as above
3) do nothing, i.e. stay with vlsi_ir being worse and unsupported in 2.4 
   forever

Please advise!

Martin

