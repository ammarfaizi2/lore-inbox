Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWAIUKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWAIUKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWAIUKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:10:37 -0500
Received: from isilmar.linta.de ([213.239.214.66]:5546 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751301AbWAIUKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:10:37 -0500
Date: Mon, 9 Jan 2006 21:10:35 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060109201035.GA10199@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Kay Sievers <kay.sievers@vrfy.org>, Greg KH <greg@kroah.com>,
	Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de> <20060106003806.GA29182@kroah.com> <20060106150334.GB20242@isilmar.linta.de> <20060106162516.GA1197@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106162516.GA1197@vrfy.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 06, 2006 at 05:25:16PM +0100, Kay Sievers wrote:
> On Fri, Jan 06, 2006 at 04:03:34PM +0100, Dominik Brodowski wrote:
> > On Thu, Jan 05, 2006 at 04:38:06PM -0800, Greg KH wrote:
> > > > NB: it will break one day, one way or another, when gregkh makes the
> > > > /sys/class -> /sys/devices conversion. However, I'd want to try not to break
> > > > the new pcmciautils userspace too often...
> > > 
> > > Why would the conversion that I'm working on break this userspace code?
> > > You are only using the device directory, which will not change at all.
> > 
> > Actually, pcmciautils uses both paths starting with
> > /sys/bus/pcmcia/devices/ and /sys/class/pcmcia_socket/pcmcia_socket%d/ --
> > and I was expecting that the latter path won't be available somewhen in
> > future?
> 
> That will just be resolved by a symlink. The access path to the device will
> stay the same, but the location of the "real" object will move to /devices.
> All classification will point into the unified /devices tree but keep
> the pathes as we have today. /sys/class will contain only symlinks in
> the end.

OK, thanks for this clarification!

	Dominik
