Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVG1PNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVG1PNN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVG1PFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:05:51 -0400
Received: from graphe.net ([209.204.138.32]:61864 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261546AbVG1PFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:05:13 -0400
Date: Thu, 28 Jul 2005 08:05:05 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Pavel Machek <pavel@suse.cz>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Alternative to TIF_FREEZE -> a notifier in the task_struct?
In-Reply-To: <20050728074116.GF6529@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0507280804310.23907@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
 <Pine.LNX.4.62.0507272018060.11863@graphe.net> <20050728074116.GF6529@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Pavel Machek wrote:

> > process. It may also allow changing values that so far cannot be
> > changed from the outside in the task struct by running a function
> > in the context of the process.
> 
> Well, we really need slightly more from "running in process context":
> we also need "no locks held" for swsusp. (But other uses probably do,
> too?)

Other uses also need "no locks held".

> I guess I'd prefer if you left "refrigerator()" and "try_to_freeze()"
> functions in; there are about 1000 drivers that know/use them, and
> some patches are probably in the queue....

Yeah but then other uses also could benefit from that.

