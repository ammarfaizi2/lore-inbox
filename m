Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSFEWZ1>; Wed, 5 Jun 2002 18:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSFEWZ0>; Wed, 5 Jun 2002 18:25:26 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:13 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S316499AbSFEWZ0>; Wed, 5 Jun 2002 18:25:26 -0400
Message-Id: <200206052219.g55MJa301032@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: device model documentation 2/3
Date: Wed, 5 Jun 2002 23:54:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>,
        <linux-hotplug-devel@lists.sourceforge.net>,
        <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0206051205150.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Juni 2002 21:11 schrieb Patrick Mochel:
> On Wed, 5 Jun 2002, Oliver Neukum wrote:
> > > SUSPEND_DISABLE tells the device to stop I/O transactions. When it
> > > stops transactions, or what it should do with unfinished transactions
> > > is a policy of the driver. After this call, the driver should not
> > > accept any other I/O requests.
> >
> > Does this mean that memory allocations in the suspend/resume
> > implementations must be made with GFP_NOIO respectively
> > GFP_ATOMIC ?
> > It would seem so.
>
> Why would you allocate memory on a resume transition?

We need to send messages to the device to restore state, don't we ?
Any activity on USB can allocate memory. We've had to change the API
to fix deadlock problems due to this already.

	Regards
		Oliver
