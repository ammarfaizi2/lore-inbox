Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUEFG7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUEFG7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 02:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUEFG67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 02:58:59 -0400
Received: from [66.35.79.110] ([66.35.79.110]:22425 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261745AbUEFG66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 02:58:58 -0400
Date: Wed, 5 May 2004 23:58:56 -0700
From: Tim Hockin <thockin@hockin.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: lazy-umount cwd and ..
Message-ID: <20040506065856.GA21004@hockin.org>
References: <20040506044433.GA13933@hockin.org> <20040506064617.GQ17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506064617.GQ17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 07:46:17AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, May 05, 2004 at 09:44:33PM -0700, Tim Hockin wrote:
> > Should I bother to polish this patch off and send it, or is it just not
> > something we want to care about?
> 
> No.  This is simply wrong - one of the situations when you want lazy-umount
> is getting a stuck filesystem (e.g. NFS mounted hard) and wanting to get
> it out of the way, so that stuff it's mounted on could be unmounted clean.
> 
> So we definitely don't want to keep anything pinned down.

I'll buy that.  I guess it's not worth dreaming up something else to make
that be less surprising to apps with cwd in a lazy umounted mount.

Cheers.
