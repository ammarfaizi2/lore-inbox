Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274880AbTHPQwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274881AbTHPQwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:52:03 -0400
Received: from mail.kroah.org ([65.200.24.183]:31914 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274880AbTHPQwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:52:00 -0400
Date: Sat, 16 Aug 2003 09:50:16 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Message-ID: <20030816165016.GE9735@kroah.com>
References: <200307152214.38825.arvidjaar@mail.ru> <200307262200.51781.arvidjaar@mail.ru> <20030815205158.GB4760@kroah.com> <200308161938.47935.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308161938.47935.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 07:38:47PM +0400, Andrey Borzenkov wrote:
> On Saturday 16 August 2003 00:51, Greg KH wrote:
> > On Sat, Jul 26, 2003 at 10:00:51PM +0400, Andrey Borzenkov wrote:
> > > Attached is patch against 2.6.0-test1 that adds type_name to all in-tree
> > > sensors; it sets it to the same values as corr. 2.4 senors and (in one
> > > case) changes client name to match that of 2.4.
> > >
> > > Assuming this patch (or variant thereof) is accepted I can then produce
> > > libsensors patch that will easily reuse current sensors.conf. I have
> > > already done it for gkrellm and as Mandrake is going to include 2.6 in
> > > next release sensors support becomes more of an issue.
> >
> > I like this idea, but now that the name logic has changed in the i2c
> > code, care to re-do this patch?  Just set the name field instead of
> > creating a new file in sysfs.
> >
> 
> something like attached patch? I like it as well :)

Why rename local variables?  Your patch would be a lot smaller if you
just keep the same local name variable, and fix up the name strings.

> note that in 2.6.0-test3 name in sysfs is empty. I had to add a chunk to 
> i2c-core to at least test my patch. or may be I misunderstood how 
> client->name is used.

No, you are correct.  I've added the name info back in the -bk tree
right now.  Try 2.6.0-test3-bk4 for the proper usage.

thanks,

greg k-h
