Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUESPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUESPno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUESPlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:41:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35535 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264247AbUESPiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:38:15 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] implement TIOCGSERIAL in sn_serial.c
Date: Wed, 19 May 2004 11:38:04 -0400
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, pfg@sgi.com,
       Erik Jacobson <erikj@sgi.com>
References: <200405191109.51751.jbarnes@engr.sgi.com> <20040519163129.A27714@infradead.org>
In-Reply-To: <20040519163129.A27714@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405191138.04086.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 19, 2004 11:31 am, Christoph Hellwig wrote:
> On Wed, May 19, 2004 at 11:09:51AM -0400, Jesse Barnes wrote:
> > The sn2 console driver behaves something like a serial port, but was
> > missing some of the ioctls that userland apps expected.  This patch
> > implements the TIOCGSERIAL ioctl, which allows applications to identify
> > the console as a serial port.
>
> And whats the point for this one?  TIOCGSERIAL is just some messy internals
> of the old serial.c driver (and serial_core now) that's exposed for the
> sake of setserial.  Given that the sn console is quite different I don't
> see the point to emulate all the mess of a real serial driver - and if you
> want to do so use the serial_core framework.

Pat is working on that and should have a patch ready to post soon (is that 
right Pat?).  In the meantime, we need this little bit.

Jesse
