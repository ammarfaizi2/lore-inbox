Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVARNmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVARNmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 08:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVARNmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 08:42:17 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:59539 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261286AbVARNmL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 08:42:11 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-12.tower-45.messagelabs.com!1106055729!9536712!1
X-StarScan-Version: 5.4.5; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.4: "access beyond end of device" after ext2 mount
Date: Tue, 18 Jan 2005 08:42:08 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC42AE@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4: "access beyond end of device" after ext2 mount
thread-index: AcT9Yj3M2ZJARW/uThecX2IcZQctdQAARtmw
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Andries Brouwer" <aebr@win.tue.nl>
Cc: "Mario Holbe" <Mario.Holbe@TU-Ilmenau.DE>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, this problem associated with drives over 32GB or 127GB on a
controller that cannot support it.  It was not discussed here, I was
wondering if that is the problem, if it is not, what type of Hard Drive
is giving you these problems?

Thanks.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Marcelo Tosatti
Sent: Tuesday, January 18, 2005 5:20 AM
To: Andries Brouwer
Cc: Mario Holbe; linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount

On Tue, Jan 18, 2005 at 01:37:08PM +0100, Andries Brouwer wrote:
> On Tue, Jan 18, 2005 at 06:45:26AM -0200, Marcelo Tosatti wrote:
> 
> > > I suppose that what happens is the following:
> > > mounting sets the blocksize to 4096.
> > > After reading 9992360 sectors, reading the next block means
reading
> > > the next 8 sectors and that fails because only 6 sectors are left.
> > 
> > So this is either not a Linux error and not a disk error, its just
that the
> > "use with filesystem" then "direct access" is a unfortunate
combination.
> 
> It is not a disk error, but I consider it a Linux error.

OK.

> > What would be the correct fix for this for this, if any?
> 
> For 2.4 my reaction would be to say that it is a known property
> of the system, possibly less fortunate, an unimportant flaw.

This seems to be harmless, so, better do nothing about it.

> Of course a fix is possible if this is deemed important for some
reason.
> 
> > v2.6 should suffer from the same issues?
> 
> I don't think so. But 2.6 details are rather different.

OK!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
