Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWDGAm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWDGAm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 20:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWDGAm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 20:42:28 -0400
Received: from fmr18.intel.com ([134.134.136.17]:13451 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932248AbWDGAm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 20:42:28 -0400
Date: Thu, 6 Apr 2006 17:41:53 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Remove unused exports and save 98Kb of kernel size
Message-ID: <20060407004153.GA11362@goober>
References: <1143925545.3076.35.camel@laptopd505.fenrus.org> <20060403141027.GC12873@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403141027.GC12873@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 04:10:27PM +0200, J?rn Engel wrote:
> On Sat, 1 April 2006 23:05:45 +0200, Arjan van de Ven wrote:
> > 
> > I've made a patch to remove all EXPORT_SYMBOL's that aren't used in the
> > kernel; it's too big for the list so it can be found at
> > 
> > http://www.kernelmorons.org/unexport.patch
> > 
> > -rwxr-xr-x 1 root root 34476416 Apr  1 21:59 vmlinux.before
> > -rwxr-xr-x 1 root root 34378112 Apr  1 22:48 vmlinux.after
> > 
> > As you can see this saves 98Kb kernel size... that's not peanuts.
> > 
> > Signed-off-by: Arjan van de Ven <arjan@kernelmorons.org>
> 
> Is there a reason that you always leave the newline instead of
> removing it as well?  Looks script-generated, so it should be a simple
> change for the script to remove the newline as well.

Because it wasn't worth fixing for a silly April Fool's joke? :)

> On Sat, 1 April 2006 23:05:45 +0200, Arjan van de Ven wrote:
          ^^^^^^^
> > http://www.kernelmorons.org/unexport.patch
               ^^^^^^^^^^^^^^^^

Of course, there's a serious side to this patch.  Who knows how many
of these exported symbols are actually used?  I can imagine a config
option to turn off these symbols which is shipped as on by default for
a few weeks, in order to flush out people who are actually using these
symbols.

-VAL
