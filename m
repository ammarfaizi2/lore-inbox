Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTJCSq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbTJCSq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:46:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:19328 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263830AbTJCSq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:46:57 -0400
Date: Fri, 3 Oct 2003 19:47:27 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310031847.h93IlRAl000348@81-2-122-30.bradfords.org.uk>
To: Erik Bourget <erik@midmaine.com>, Tomasz Rola <rtomek@cis.com.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87k77m89kt.fsf@loki.odinnet>
References: <Pine.LNX.3.96.1031003200237.19402A-100000@pioneer.space.nemesis.pl>
 <87k77m89kt.fsf@loki.odinnet>
Subject: Re: CMD680, kernel 2.4.21, and heartache
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Erik Bourget <erik@midmaine.com>:
> Tomasz Rola <rtomek@cis.com.pl> writes:
> 
> > On Fri, 3 Oct 2003, Erik Bourget wrote:
> >
> >> Erik Bourget <erik@midmaine.com> writes:
> >> 
> >> (194)Temperature             0x0002   196   196   000       1441854
> >
> > You should definitely take a look at other drives data in all computers,
> > esp. temperature. Consult this with max allowed temperature as defined by
> > hd manufacturer for this specific type of the drive (should be somewhere
> > on their website or on google). Each disk is different but the general
> > safe bet for a limit is 40-45 oC, from what I know.
> >
> > Your room may be cool but it's better to check.
> 
> Yeah, it says 196, and that's bizarre.  196 whats?  From looking at other
> example output, the '1441854' number is usually the true deg. C of the
> machine.  But I'm reasonably sure that it's not at a million and a half
> centigrade.

The units of the value, worst, and threshold fields are not important
- it's all relative.

Yes, the raw value field is usually the temperature in C as measured
by an on-board sensor, but as far as I know, there is no _requirement_
for it to be.  I've seen disks which report the power on hours in
minutes, for example.

I think the raw value field is really provided for extra-information
purposes - it's better to use the value, worst and threshold fields.

Basically, as long as the value field doesn't reach the threshold
field, don't worry about that aspect of the drive.  Note, the value
may count up or down.  The worst field may or may not be preserved
over a power cycle, that is drive dependant.

John.
