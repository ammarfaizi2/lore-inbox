Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVCEJGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVCEJGO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 04:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVCEJGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 04:06:14 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:18109 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261511AbVCEJGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 04:06:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ncunningham@cyclades.com
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Date: Sat, 5 Mar 2005 10:08:05 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com
References: <200502252237.04110.rjw@sisk.pl> <20050304234149.GD2647@elf.ucw.cz> <1109985002.3772.325.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1109985002.3772.325.camel@desktop.cunningham.myip.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503051008.05681.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 5 of March 2005 02:10, Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2005-03-05 at 10:41, Pavel Machek wrote:
> > > non-RAM areas with PG_nosave, at least for sanity reasons (eg to be sure that
> > > we do not break things by dumping stuff to where we should not write to).
> > 
> > I'm not sure if it is not better to save & restore non-RAM areas, but
> > it probably just does not matter.

For the address ranges that are reported by the BIOS as reserved, it
probably doesn't matter indeed, but for the address ranges that are
not reported at all, it's potentially dangerous.  Unfortunately
they all are generally treated in the same way, so why should we do it
differently?
 
> IIRC, it does matter. I think there were situations where you got
> something nasty (MCE/oops/freeze) if you tried reading memory that
> doesn't exist. If you push me I'll put the effort into looking up
> suspend2 archives to find the discussion :>

If you're so kind, that would be great!

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
