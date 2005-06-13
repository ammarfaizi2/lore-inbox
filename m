Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVFMXp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVFMXp5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVFMXpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:45:20 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:1375 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261493AbVFMWFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:05:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Input sysbsystema and hotplug
Date: Mon, 13 Jun 2005 17:05:29 -0500
User-Agent: KMail/1.8.1
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Hannes Reinecke <hare@suse.de>, Andrew Morton <akpm@osdl.org>
References: <200506131607.51736.dtor_core@ameritech.net> <20050613212654.GB11182@vrfy.org> <200506131658.37583.dtor_core@ameritech.net>
In-Reply-To: <200506131658.37583.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506131705.30159.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 16:58, Dmitry Torokhov wrote:
> On Monday 13 June 2005 16:26, Kay Sievers wrote:
> > On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> > > I am trying to convert input systsem to play nicely with sysfs and I am
> > > having trouble with hotplug agent. The old hotplug mechanism was using
> > > "input" as agent/subsystem name, unfortunately I can't simply use "input"
> > > class because when Greg added class_simple support to input handlers
> > > (evdev, mousedev, joydev, etc) he used that name. So currently stock
> > > kernel gets 2 types of hotplug events (from input core and from input
> > > handlers) with completely different arguments processed by the same
> > > input agent.
> > > 
> > > So I guess my question is: is there anyone who uses hotplug events
> > > for input interface devices (as in mouseX, eventX) as opposed to
> > > parent input devices (inputX).
> > 
> > Hmm, udev uses it. But, who needs device nodes. :)
> > 
> 
> Oh, OK. Damn, Andrew will hate us for breaking mouse support yet again :(
> because there are people (like me) relying on hotplug to load input handlers.
> First time I booted by new input hotplug kernel I lost my mouse.
> 
> I wonder should we hack something allowing overriding subsystem name
> so we could keep the same hotplug agent? Or should we bite teh bullet and
> change it?
>

Any chance we could quickly agree on a new name for hander devices (other
than "input") and roll out updated udev before the changes get into the
kernel? For some reason it feels like udev is mmuch quicker moving than
hotplug...

-- 
Dmitry
