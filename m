Return-Path: <linux-kernel-owner+willy=40w.ods.org-S278155AbUKBA10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S278155AbUKBA10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S292686AbUKBA1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:27:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:4748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S292593AbUKBA0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:26:07 -0500
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Date: Tue, 2 Nov 2004 01:26:01 +0100
User-Agent: KMail/1.7.50
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>, jsimmons@infradead.org,
       geert@linux-m68k.org, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
References: <Pine.LNX.4.10.10411011719270.2438-100000@mtfhpc.demon.co.uk> <200411020746.27871.adaplas@hotpop.com>
In-Reply-To: <200411020746.27871.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411020126.01891.deller@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 00:46, Antonino A. Daplas wrote:
> On Tuesday 02 November 2004 01:32, Mark Fortescue wrote:
> > Hi all,
> >
> > Thanks for the info Antonino. I see you spotted my typing error. Yes it is
> > the 2.6.10-rc1-bk6 kernel. The oter error is the 2.2.8.1. It should be
> > 2.6.8.1.
> >
> > The cgthree driver does not currently set up the all->info.var.red,
> > all->info.var.green or all->info.var.blue structures. Putting a value of 8
> > in the length field of these structures (correct for the cgthree) does get
> > me my logo back but I am still getting black on black text. It makes it
> > very difficult to read. It is begining to look like there is something
> > werid going on with the colour pallet stuf for PSEUDO_COLOUR.

I saw similiar problems with the stifb driver on HPPA. 
Changing the driver's pseudo_palette[] struct to support 256 colors solved this problem.
But there might be a problem in higher levels as well....

Helge
