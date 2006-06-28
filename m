Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWF1TJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWF1TJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWF1TJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:09:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:33495 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750835AbWF1TJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:09:19 -0400
Date: Wed, 28 Jun 2006 14:08:22 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: please revert kthread from loop.c
Message-ID: <20060628190822.GB17482@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606261920440.1330@blonde.wat.veritas.com> <20060627054612.GA15657@sergelap.austin.ibm.com> <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606281933300.24170@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hugh Dickins (hugh@veritas.com):
> > 	This version has passed parallel runs of the following
> > 	script (on different devices of course), i.e.
> 
> But not good for me.  Gets further e.g. 170 iterations,
> but then hangs while kthread_stop waits for completion.

Confounded...

> I haven't investigated further.  Is there really any reason
> to be messing with what has worked well for so long here?

Only because loop.c can be compiled as a module, and kernel_thread
is slated to have it's EXPORT_SYMBOL removed.

-serge
