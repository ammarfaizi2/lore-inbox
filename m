Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbSLITPb>; Mon, 9 Dec 2002 14:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbSLITPb>; Mon, 9 Dec 2002 14:15:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29956 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266081AbSLITP3>; Mon, 9 Dec 2002 14:15:29 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
Date: 9 Dec 2002 11:23:03 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <at2qin$fgn$1@cesium.transmeta.com>
References: <9633612287A@vcnet.vc.cvut.cz> <20021206090234.GA1940@zaurus> <3DF4DEC0.3030800@zytor.com> <20021209182605.GA22747@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20021209182605.GA22747@atrey.karlin.mff.cuni.cz>
By author:    Pavel Machek <pavel@ucw.cz>
In newsgroup: linux.dev.kernel
>
> Hi!
> 
> > > Why can't we simply have /bin/bash_that_splits_args_itself
> > 
> > We could, but it would in practice mean doing an extra exec() for each
> > executable.  This seems undesirable.
> 
> Only for executables that need argument spliting... For such scripts I
> guess we can get handle the overhead.
> 

We probably can, but a better question is really: what are the
semantics that users expect?  Given that Unices are by and large
inconsistent, we should pick the behaviour that makes sense to the
most people.  I suspect that most people would expect whitespace
partition.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
