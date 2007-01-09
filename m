Return-Path: <linux-kernel-owner+w=401wt.eu-S1750901AbXAIBvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbXAIBvF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbXAIBvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:51:04 -0500
Received: from cs.columbia.edu ([128.59.16.20]:41708 "EHLO cs.columbia.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbXAIBvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:51:02 -0500
Subject: Re: [PATCH 01/24] Unionfs: Documentation
From: Shaya Potter <spotter@cs.columbia.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0701090226340.20773@yvahk01.tjqt.qr>
References: <20070108111852.ee156a90.akpm@osdl.org>
	 <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
	 <1pw35070vgjt0.vkrm8bjemedb$.dlg@40tude.net>
	 <20070109003230.GD5418@filer.fsl.cs.sunysb.edu>
	 <Pine.LNX.4.61.0701090226340.20773@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 20:50:42 -0500
Message-Id: <1168307442.5024.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.4 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter1.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 02:26 +0100, Jan Engelhardt wrote:
> On Jan 8 2007 19:33, Josef Sipek wrote:
> >On Tue, Jan 09, 2007 at 01:19:48AM +0100, Giuseppe Bilotta wrote:
> >> As a simple user without much knowledge of kernel internals, much less
> >> so filesystems, couldn't something based on the same principle of
> >> lsof+fam be used to handle these situations?
> >
> >Using inotify has been suggested before. That let the upper filesystem
> >know when something changed on the lower filesystem.
> >
> >I think that, while it would work, it is not the right solution.
> 
> Because inotify is not recursive yet?

Even if it was, using inotify would be inherently racy (what if two
writes start at the same time)

