Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVKIRTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVKIRTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbVKIRTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:19:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:60904 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932640AbVKIRTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:19:46 -0500
Date: Wed, 9 Nov 2005 09:19:19 -0800
From: Greg KH <greg@kroah.com>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/39] NLKD - early/late CPU up/down notification
Message-ID: <20051109171919.GA32761@kroah.com>
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <20051109164544.GB32068@kroah.com> <43723B57.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43723B57.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 06:09:27PM +0100, Jan Beulich wrote:
> >>> Greg KH <greg@kroah.com> 09.11.05 17:45:44 >>>
> >#ifdef in the .h file is not needed.  Please fix your email client to
> >send patches properly.
> 
> It's not needed, sure, but by having it there I just wanted to make
> clear that this is something that never can be called from a module
> (after all, why should one find out at modpost time (and maybe even miss
> the message since there are so many past eventual symbol resolution
> warnings) when one can already at compile time.

If it isn't present, and you do a build, you will still get the error at
build time, just during a different part of it.  Adding #ifdef just to
move the error to a different part of the build isn't needed.  Remember,
we want to not use #ifdef at all if we can ever help it.

thanks,

greg k-h
