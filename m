Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUESPbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUESPbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbUESPbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:31:50 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:3086 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264238AbUESPbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:31:33 -0400
Date: Wed, 19 May 2004 16:31:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, pfg@sgi.com,
       Erik Jacobson <erikj@sgi.com>
Subject: Re: [PATCH] implement TIOCGSERIAL in sn_serial.c
Message-ID: <20040519163129.A27714@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, pfg@sgi.com,
	Erik Jacobson <erikj@sgi.com>
References: <200405191109.51751.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200405191109.51751.jbarnes@engr.sgi.com>; from jbarnes@engr.sgi.com on Wed, May 19, 2004 at 11:09:51AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 11:09:51AM -0400, Jesse Barnes wrote:
> The sn2 console driver behaves something like a serial port, but was missing 
> some of the ioctls that userland apps expected.  This patch implements the 
> TIOCGSERIAL ioctl, which allows applications to identify the console as a 
> serial port.

And whats the point for this one?  TIOCGSERIAL is just some messy internals
of the old serial.c driver (and serial_core now) that's exposed for the
sake of setserial.  Given that the sn console is quite different I don't
see the point to emulate all the mess of a real serial driver - and if you
want to do so use the serial_core framework.

