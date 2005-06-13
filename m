Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVFMMex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVFMMex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVFMMeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:34:31 -0400
Received: from gs.bofh.at ([193.154.150.68]:24784 "EHLO gs.bofh.at")
	by vger.kernel.org with ESMTP id S261541AbVFMMeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:34:24 -0400
Subject: Re: udp.c
From: Bernd Petrovitsch <bernd@firmix.at>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Cc: linux-kernel@vger.kernel.org, Rommer <rommer@active.by>
In-Reply-To: <yw1xy89ebg14.fsf@ford.inprovide.com>
References: <42AD74A3.1050006@active.by>
	 <1118664180.898.13.camel@tara.firmix.at>
	 <yw1xy89ebg14.fsf@ford.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-15
Organization: Firmix Software GmbH
Date: Mon, 13 Jun 2005 14:34:18 +0200
Message-Id: <1118666058.898.23.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 14:24 +0200, Måns Rullgård wrote:
> Bernd Petrovitsch <bernd@firmix.at> writes:
> 
> > On Mon, 2005-06-13 at 14:57 +0300, Rommer wrote:
> >> Where used strange function udp_v4_hash?
> >> linux-2.6.11.11, net/ipv4/udp.c:204
> >> 
> >> static void udp_v4_hash(struct sock *sk)
> >
> > Since it is "static" the user must be in the same source file (or -
> > theoretically - any included header).
> 
> It's not that simple.  It is assigned to the 'hash' field of a struct

If you interpret "called" word-by-word yes. I assumed "used".

> proto, which is exported.  It could be used from anywhere, but

The the OP has to grep for dereferences for this hash variable and check
if it is (or may be) from the given struct.
Well, that's the virtue of object-orientation: Follow the objects, not
the functions/methods.

> hopefully isn't.  Something else is supposed to ensure that it is
> never called when using the UDP protocol.

Apparently.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

