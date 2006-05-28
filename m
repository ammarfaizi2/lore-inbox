Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWE1WCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWE1WCN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 18:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWE1WCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 18:02:13 -0400
Received: from rune.pobox.com ([208.210.124.79]:21650 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1750980AbWE1WCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 18:02:13 -0400
Date: Sun, 28 May 2006 15:02:08 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bisects that are neither good nor bad
Message-Id: <20060528150208.3a606c1c.dickson@permanentmail.com>
In-Reply-To: <200605282324.13431.rjw@sisk.pl>
References: <20060528140238.2c25a805.dickson@permanentmail.com>
	<20060528140854.34ddec2a.paul@permanentmail.com>
	<200605282324.13431.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006 23:24:12 +0200, Rafael J. Wysocki wrote:

> On Sunday 28 May 2006 23:08, Paul Dickson wrote:
> > On Sun, 28 May 2006 14:02:38 -0700, Paul Dickson wrote:
> > 
> > > Building and testing a good kernel takes me about 70 minutes.  If I make
> > > mistakes it can easily take two times (or more!) longer.
> > >
> > > I'm currently tracking my work at:
> > >     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185108
> > >
> > > I'm currently building my fifth bisect.
> 
> Could you please also try if the problems persist if you boot with
> init=/bin/bash?

I'll try it after I send this message.  I'm guessing you're refering to
my third bisect.  I still have that and will use it.

I also have my 5th bisect ready for this reboot too...


> Besides, it would be helpful if you were able to get a serial console log
> from the failing system.

No serial port on this notebook.  I've tried
"netconsole=4444@192.168.1.9/eth0,6666@192.168.1.3/00:01:02:77:7D:E1" but
nothing happens (there's not even a log message that this is unsupported).


> > Is there a method of bisecting that means neither "good" nor "bad"?  I
> > have run into kernel problems that are not related to the problem I'm
> > attempting to track.  Some are not avoidable by changing the .config (see
> > the third bisect in comments 10 and 11 in the bugzilla report).
> 
> There are lots of patches between 2.6.16-rc* and 2.6.17-rc1, most of them
> having stayed in -mm for some time.  If you found the first failing -mm kernel,
> it would be easier to catch the offending patch.
> 
> BTW, have you tried any kernel _after_ 2.6.17-rc1?  If not, I'd start from
> these.

I have been using the Fedora development kernels.  The last I'm SURE I
tested was 2211 (2.6.17-rc4-git11).  It has the same problems as the
2.6.17-rc1 I compiled from the git database.  It's been the same
throughout the series.

I may try sshing into my notebook when I finish these current bisect
tests to see if it's still the HD being made RO.  This is assuming ssh
will keep the connection through a suspend.

	-Paul
