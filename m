Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVBAIBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVBAIBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVBAH76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:59:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:32675 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261860AbVBAH4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:56:02 -0500
Date: Mon, 31 Jan 2005 23:53:48 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: 7eggert@gmx.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aoe: add documentation for udev users
Message-ID: <20050201075348.GC21608@kroah.com>
References: <fa.gl94rva.1tkib28@ifi.uio.no> <E1CrSfr-0001l2-Et@be1.7eggert.dyndns.org> <877jm8kwt6.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877jm8kwt6.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 09:19:17AM -0500, Ed L Cashin wrote:
> Bodo Eggert <7eggert@gmx.de> writes:
> 
> > Ed L Cashin <ecashin@coraid.com> wrote:
> >
> >> +if?test?-z?"$conf";?then
> >> +????????conf="`find?/etc?-type?f?-name?udev.conf?2>?/dev/null`"
> >> +fi
> >> +if?test?-z?"$conf"?||?test?!?-r?$conf;?then
> >> +????????echo?"$me?Error:?could?not?find?readable?udev.conf?in?/etc"?1>&2
> >> +????????exit?1
> >> +fi
> >
> > This will fail and print
> > ---
> > bash: test: etc/udev.conf: binary operator expected
> > ---
> > if there is more than one udev.conf.
> >
> > Fix: Always put quotes around variables.
> 
> Thanks.  With the changes below, it still will complain if it finds
> more than one udev.conf, but only if /etc/udev/udev.conf doesn't
> exist.
> 
> 
> Quote all shell variables, and use /etc/udev/udev.conf if available.
> 
> Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

Applied, thanks.

greg k-h

