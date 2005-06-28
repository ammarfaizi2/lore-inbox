Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVF1Wf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVF1Wf7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVF1Wf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:35:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:61395 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261168AbVF1Wcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:32:47 -0400
Date: Tue, 28 Jun 2005 15:32:15 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
       James.Bottomley@SteelEye.com, tytso@mit.edu, zwane@arm.linux.org.uk,
       jmforbes@linuxtx.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, andrew.vasquez@qlogic.com,
       chuckw@quantumlinux.com, stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow board initialization.
Message-ID: <20050628223215.GA16048@kroah.com>
References: <20050627224651.GI9046@shell0.pdx.osdl.net> <20050627225349.GK9046@shell0.pdx.osdl.net> <20050628235148.4512d046.khali@linux-fr.org> <20050628152037.690c3840.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628152037.690c3840.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 03:20:37PM -0700, Andrew Morton wrote:
> Jean Delvare <khali@linux-fr.org> wrote:
> >
> > Hi Chris, all,
> > 
> > > -stable review patch.  If anyone has any objections, please let us
> > > know.
> > 
> > I have. This one patch is rather big and parts of it don't seem to
> > belong to -stable. Can't it be simplified? More below.
> 
> The threshold for "what belongs in -stable" is a) set too high and b)
> over-zealously enforced.

Hm, are there patches that have been submitted to stable@ that have been
rejected for "over-zealous" enforcement?  I can't think of any ones
recently.

> > > Return to previous held-logic of calling scsi_add_host() only
> > > after the board has been completely initialized.
> > 
> > What real bug is it supposed to fix? (I guess some, but this leading
> > comment should give the datails.)
> 
> If that's what was in the patch which went into 2.6.13 then we should be OK
> with a full backport.  If the person who originally raised that patch put
> unrelated things into a single patch then that's where the problem started.
> 
> Bear in mind that there is also risk in only part-applying a patch.

I agree.  That's why I don't have a problem with this patch, it's better
to stay inline with upstream (meaning 2.6.12-git) than diverging.  Makes
my life easier when I try to figure out if stuff needs to be merged to
Linus :)

thanks,

greg k-h
