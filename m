Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbUBYXYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUBYXVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:21:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:12938 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261572AbUBYXPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:15:12 -0500
X-Authenticated: #20799612
Date: Thu, 26 Feb 2004 00:14:39 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Paul Jackson <pj@sgi.com>
Cc: aebr@win.tue.nl, jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040225231439.GB7744@hobbes>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040222225750.GA27402@mail.shareable.org> <20040222214457.6f8d2224.pj@sgi.com> <20040223202524.GC13914@hobbes> <20040223140027.5c035157.pj@sgi.com> <20040224001313.GA6426@hobbes> <20040223173246.5998e0a1.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223173246.5998e0a1.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 05:32:46PM -0800, Paul Jackson wrote:
> > So, I really can't see any problem with such a shell...
> 
> I think we are agreeing on the technical details.
> 
> But not on the relative weight of the potential problems
> versus the value of the change you propose.

Okay. So the "result" of this discussion seems to be:

We agree, that it is not that likely that there will be a lot of
problems caused by existing scripts with a shebang line with one
argument containing spaces. But you still consider this too risky,
whereas Jamie Lokier (if I understood him right) and I think, the risk
is low enough.

The '\'-part seems to be more problematic and not that useful. So, this
part could be removed from the patch.

Andries Brouwer's web page shows me, that there are operating systems
that already split arguments, which seems to work without a lot of
problems, while you emphasize the fact, that there are more operating
systems parsing the shebang line the "old" way.

So, talking about the same facts, we still disagree, and I don't think
further discussion will change this. How should we proceed? Should we
still wait for other comments (I'd really like to know what people
think about it)? Should I ask Andrew Morton what he thinks about it,
also with regard to our discussion? Or do you still see facts, we should
talk about?

Regards,

	Hansjoerg Lipp
