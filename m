Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVF0Dfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVF0Dfm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 23:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVF0Dfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 23:35:42 -0400
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:39350 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261789AbVF0DfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 23:35:25 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: hdaps-devel@lists.sourceforge.net
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Date: Sun, 26 Jun 2005 23:35:15 -0400
User-Agent: KMail/1.8.1
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org
References: <1119559367.20628.5.camel@mindpipe> <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>
In-Reply-To: <20050625200953.GA1591@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506262335.16899.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Perhaps a kernel space daemon but with some ioctls that userspace can 
manipulate?

Or can the whole daemon be offloaded to userspace? Having some driver ioctls 
and a sysfs interface would allow the KDE and GNOME people to read the sysfs 
info and parse accordingly for some nifty tools.

Sounds good?

Shawn.


On June 25, 2005 16:09, Vojtech Pavlik wrote:
> On Sat, Jun 25, 2005 at 01:13:17PM -0500, Alejandro Bonilla wrote:
> > I have a question here, how do you guys think that the head is parked,
> > is it done by the controller directly, which then sends the command to
> > the HD to park the head, or this is done by the operating system in some
> > kind of way?
> >
> > I think the OS or user space is too slow like to react to send a park
> > command to the hard drive, so this most be done directly by the embedded
> > controller, but still I think it needs some input from the OS, to
> > initialize it's settings.
>
> The only way to park a drive is to send a command to it through the IDE
> interface. This can't be done by the controller itself, since the
> controller in the ThinkPad is a classic Intel ICH chip which only passes
> commands around.
>
> The OS is definitely fast enough for this kind of task, it's doable even
> in userspace, although not easy.
>
> > i.e. after all, in windows you do have the settings in the software
> > for HDAPS, but it looks like it is _not_ managed by the operating
> > system at all if there is some type of action to  be taken. This is
> > also probably why HDAPS won't kick in until booted, and that is
> > because it needs to load its config setup by the software.
> >
> > This is what I think, please correct me if I'm saying something crazy.
>
> It is definitely all done by the windows kernel driver.
