Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUHHLPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUHHLPS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 07:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUHHLPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 07:15:18 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:29138 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S265250AbUHHLPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 07:15:11 -0400
X-Sender-Authentication: net64
Date: Sun, 8 Aug 2004 13:15:07 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040808131507.147d57f6.skraw@ithnet.com>
In-Reply-To: <cf11qi$hjm$1@terminus.zytor.com>
References: <200408061018.i76AIdmV005276@burner.fokus.fraunhofer.de>
	<20040806175937.GA296@ucw.cz>
	<cf11qi$hjm$1@terminus.zytor.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004 22:47:46 +0000 (UTC)
hpa@zytor.com (H. Peter Anvin) wrote:

> Followup to:  <20040806175937.GA296@ucw.cz>
> By author:    Vojtech Pavlik <vojtech@suse.cz>
> In newsgroup: linux.dev.kernel
> > > 
> > > If you do not fix this, you just verify that Linux does not like it's
> > > users. Linux users like to call cdrecord -scanbus and they like to see
> > > _all_ SCSI devices from a single call to cdrecord. The fact that the
> > > Linux kernel does not return instance numbers for /dev/hd* SCSI devices
> > > makes it impossible to implement a unique address space :-(
> >  
> > I'm a long time Linux and cdrecord user, and I must say I always hated
> > the -scanbus thingy. It's so much easier to just pass the /dev/hdc
> > device node, where I _know_ my CD burner lives than to have to figure
> > out what fake SCSI address cdrecord has made up and requires me to pass
> > to it, even when I have just a single CD burner in my system.
> > 
> 
> Indeed.  To a first order it doesn't matter if the default system
> namespace is crappy -- applications inventing its own namespaces
> (usually inconsistently) means that it's IMPOSSIBLE to make all
> applications do the same thing - which is actually more important to
> make them all do "the right thing."  Furthermore, it blocks
> improvements such as udev.
> 
> Note there is nothing that says cdrecord -scanbus can't print out
> a list, using the system device names.
> 

To add a pure users' comment to the story:

Maybe you should not overestimate cdrecord as a tool (like its author obviously
does sometimes). At least for DVD there are well-working alternatives.

If Joerg feels a better home on Solaris, so be it. It's his right to decide for
solaris, just as it is a users' right to decide against cdrecord.


Regards,
Stephan
