Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbULPXwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbULPXwV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbULPXwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:52:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:9434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262031AbULPXwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:52:14 -0500
Date: Thu, 16 Dec 2004 15:51:47 -0800
From: Greg KH <greg@kroah.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041216235147.GC11330@kroah.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com> <41C20356.4010900@sun.com> <20041216221843.GA10172@kroah.com> <20041216144531.3a8d988c@lembas.zaitcev.lan> <20041216225323.GA10616@kroah.com> <Pine.LNX.4.60.0412170033160.25628@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0412170033160.25628@alpha.polcom.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 12:39:00AM +0100, Grzegorz Kulewski wrote:
> On Thu, 16 Dec 2004, Greg KH wrote:
> 
> >On Thu, Dec 16, 2004 at 02:45:31PM -0800, Pete Zaitcev wrote:
> >>On Thu, 16 Dec 2004 14:18:43 -0800, Greg KH <greg@kroah.com> wrote:
> >>
> >>>Hm, what about /.debug ?  That's a compromise that I can live with (even
> >>>less key strokes to get to...)
> >>
> >>No way, Jan is out of his mind, adding obfuscations like that. Anything
> >>but that. I didn't even bother to reply, because it never occurred to me
> >>that you'd fall for something so retarded.
> >
> >Bah, fine :)
> >
> >>Otherwise, /dbg sounds good.
> >
> >Ok, I can live with that.
> 
> I agree that anything like /.* is broken and strange... But this is only 
> my little opinion. :-)
> 
> But why creating dir in /proc - like /proc/debug is bad? Its advantages:
> - it does not pollute namespace,
> - it can be created by kernel at startup even on systems where debugfs 
> will not be used (why not?),
> - /proc is mounted in all configurations and often it is the first thing 
> that startscripts do,
> - if somebody really needs to debug proc using debugfs he can always mount 
> it as /debug temporaily.

Disadvantage:
 - it puts a non-process type thing into /proc which is what I am
   specifically trying to get away from doing.

Only process related things _should_ be in /proc.  Now if I can ever
fully achieve that goal in my lifetime is something that is left to be
seen...

thanks,

greg k-h
