Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbUJ0GMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbUJ0GMM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUJ0GJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:09:19 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:35694 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261679AbUJ0GIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:08:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Input: sunkbd concern
Date: Wed, 27 Oct 2004 01:08:41 -0500
User-Agent: KMail/1.6.2
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <200410221833.04057.dtor_core@ameritech.net> <200410262032.27938.dtor_core@ameritech.net> <20041027054706.GA1211@ucw.cz>
In-Reply-To: <20041027054706.GA1211@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410270108.41328.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 12:47 am, Vojtech Pavlik wrote:
> On Tue, Oct 26, 2004 at 08:32:27PM -0500, Dmitry Torokhov wrote:
> > On Tuesday 26 October 2004 08:06 pm, David S. Miller wrote:
> > > On Fri, 22 Oct 2004 18:33:04 -0500
> > > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > 
> > > > I have been looking at sunkbd.c and it seems that it attaches not only to
> > > > ports that speak SUNKBD protocol but also to ports that do not specify any
> > > > protocol:
> > > > 
> > > > 	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) != SERIO_SUNKBD)
> > > > 		return;
> > > > 
> > > > Was that an oversight or it was done intentionally?
> > > 
> > > I believe it is intentional.
> > > 
> > > If SERIO_PROTO bits are all clear, this is supposed to have
> > > a special meaning in that any keyboard driver can claim
> > > the serio line.
> > > 
> > > So if it's the "wildcard" zero value, or specifically SERIO_SUNKBD,
> > > we'll attach to it.
> > > 
> > 
> > I would buy if I see another keyboard doing this, but so far only sunkbd
> > does this. The rest of keyboards connecting to a RS232-type ports require
> > exact protocol match...
> > 
> > The background is that I am trying to create a bus "match" function for
> > serio and trying to understand the requirements... 
>  
> IIRC my intention was that if the driver can autoprobe for the device,
> it shouldn't require 'inputattach' to specify the protocol, which is the
> case of sunkbd, but not other serial port keyboards.
> 

Ok, I see now. Thanks!

-- 
Dmitry
