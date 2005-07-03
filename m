Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVGCFdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVGCFdW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 01:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVGCFdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 01:33:22 -0400
Received: from smtpout4.uol.com.br ([200.221.4.195]:14470 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261365AbVGCFdQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 01:33:16 -0400
Date: Sun, 3 Jul 2005 02:33:04 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Firewire/SBP2 and the -mm tree
Message-ID: <20050703053304.GA815@ime.usp.br>
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Andrew Morton <akpm@osdl.org>
References: <20050701044018.281b1ebd.akpm@osdl.org> <200507020005.04947.rjw@sisk.pl> <20050702031955.GC28251@ime.usp.br> <42C664CE.9020009@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42C664CE.9020009@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stefan.

Sorry for the late reply, but I am about to be submitted to a surgery and
had to make some health tests, which prevented me from trying to debug
things regarding this problem.

On Jul 02 2005, Stefan Richter wrote:
> That is what usually happens. But the sbp2 related diffs between 2.6.13 
> and linux1394 are not an update by linux1394 but rather a rewrite by the 
> scsi folk.

Ok, I see.

> Unfortunately, that rewrite was not tested by the linux1394 team. (And
> was therefore not checked in at svn.linux1394.org. Lack of manpower was
> one factor.) So, applying the sbp2 portion of your diff is a back-out,
> not an update.

Well, it surely looked like an update, since the revision number of the svn
repo was higher than what is in the kernel right now. But that's from the
standpoint from a luser (me).

> I have a question: Do you need _both_ the sbp2 back-out and ieee1394's
> disable_irm parameter, or only one of them?

With 2.6.13-rc1, I just need the sbp2.[ch] files patched from trunk and
everything works fine (that is, BTW, what I am using right now).

But with the recently released 2.6.13-rc1-mm1, patching the sbp2.[ch] files
isn't sufficient anymore (i.e., I get results similar to what I had when I
first started this thread).

I have not yet had time to pass the disable_irm parameter to a -rc1-mm1
kernel (patched or not), but will do (or anything else, if you guys want me
to) so that we can have Linus's kernel 2.6.13 working as 2.6.12 did (but
with the nice improvements to other subsystems also). :-)


Thank you very much, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
