Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWCJIRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWCJIRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWCJIRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:17:07 -0500
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:45795 "EHLO
	mailgate2.urz.uni-halle.de") by vger.kernel.org with ESMTP
	id S1751252AbWCJIRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:17:06 -0500
Date: Fri, 10 Mar 2006 09:16:09 +0100
From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/usb usbaudio.c,1.172,1.173
In-reply-to: <1141940987.13319.71.camel@mindpipe>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       usb-devel@lists.sourceforge.net
Message-id: <20060310081609.GB10971@turing.informatik.uni-halle.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <E1FHG2j-0001sX-Ln@sc8-pr-cvs1.sourceforge.net>
 <1141940987.13319.71.camel@mindpipe>
X-Scan-Signature: 629ca88677f1133e8c9b638e5f64dd99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2006-03-08 at 23:58 -0800, Clemens Ladisch wrote:
> > +static const char *usb_error_string(int err)
> > +{
> > +	switch (err) {
> > +	case -ENODEV:
> > +		return "no device";
> > +	case -ENOENT:
> > +		return "endpoint not enabled";
> > +	case -EPIPE:
> > +		return "endpoint stalled";
> > +	case -ENOSPC:
> > +		return "not enough bandwidth";
> > +	case -ESHUTDOWN:
> > +		return "device disabled";
> > +	case -EHOSTUNREACH:
> > +		return "device suspended";
> > +	case -EINVAL:
> > +	case -EAGAIN:
> > +	case -EFBIG:
> > +	case -EMSGSIZE:
> > +		return "internal error";
> > +	default:
> > +		return "unknown error";
> > +	}
> > +}
> 
> Shouldn't a generic facility be created for this?

Yes, there's nothing audio specific in this function (except for my
decision which codes to lump together as "internal error").

> After all these are standard error codes and it seem like other parts
> of the kernel might want to do user friendly error reporting.

But it seems none of those parts actually does.  ;-)


Clemens
