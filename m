Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbTGBF3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 01:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbTGBF3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 01:29:36 -0400
Received: from granite.he.net ([216.218.226.66]:38922 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264723AbTGBF3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 01:29:34 -0400
Date: Tue, 1 Jul 2003 22:26:59 -0700
From: Greg KH <greg@kroah.com>
To: Justin A <justin@bouncybouncy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb serial/visor oops in 2.4.22-pre2
Message-ID: <20030702052659.GA5661@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <1057106020.22290.17.camel@s.bouncybouncy.net> <20030702005724.GA2337@kroah.com> <1057107790.22288.23.camel@s.bouncybouncy.net> <20030702033246.GA3272@kroah.com> <1057119450.22291.54.camel@s.bouncybouncy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057119450.22291.54.camel@s.bouncybouncy.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 12:17:30AM -0400, Justin A wrote:
> On Tue, 2003-07-01 at 23:32, Greg KH wrote:
> > Any reason for not sending this to linux-kernel too?
> 
> hmmm i think you mean the linux-usb list too?

No, you sent to me privately, and not CC lkml.

> > On Tue, Jul 01, 2003 at 09:03:10PM -0400, Justin A wrote:
> > > On Tue, 2003-07-01 at 20:57, Greg KH wrote:
> > > > On Tue, Jul 01, 2003 at 08:33:40PM -0400, Justin A wrote:
> > > > > basically, pilot-xfer and all don't work anymore, dmesg reports:
> > > > 
> > > > But 2.4.21 works just fine for you?
> > > dunno, I went from 2.4.21-rc6 to 2.2.22-pre2
> > > it sorta worked once or twice in 2.2.21-rc6, but then stopped working.
> > 
> > With the same oops?
> yeah, that or it would just timeout but no oops.
> The thing about the oops is that it happens when it times out after not
> establishing a connecting, it's not that I hit the sync button and it
> immediately oopses.

It oopses when the close() happens, right?  That's a common bug right
now in 2.4 :(

It's fixed in 2.5, if you want to try that.

> > > I had been out of batteries for a while, so I can't remember the last
> > > kernel it worked perfectly with, but I think it was 2.4.21-pre5-ac3
> > > 
> > > If you want I'll test a specific config.
> > > > What USB host driver are you using?
> > > uhci
> > 
> > Can you try usb-uhci and see if it works better?
> I am using usb-uhci.. forgot there was a driver named just 'uhci' :)

Then try uhci, people have found that this sometimes works.

thanks,

greg k-h
