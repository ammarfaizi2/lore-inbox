Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVFVKx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVFVKx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbVFVKwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:52:15 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:60358 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S262788AbVFVKvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 06:51:04 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Erik Slagter <erik@slagter.name>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1119359264.3035.5.camel@localhost.localdomain>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <1119357351.3325.124.camel@localhost.localdomain>
	 <1119359264.3035.5.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Jun 2005 12:50:33 +0200
Message-Id: <1119437433.4002.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 09:07 -0400, Arjan van de Ven wrote:
> On Tue, 2005-06-21 at 13:35 +0100, Alan Cox wrote:
> > On Maw, 2005-06-21 at 07:54, Andrew Morton wrote:
> > > CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ Kconfigurable.
> > >     Will merge (will switch default to 1000 Hz later if that seems necessary)
> > 
> > This has been in Fedora for a while. DaveJ can probably give you more
> > info. From own testing 100Hz is how far down you want to go to avoid
> > random clock slew on laptops and to see power improvements.
> 
> actually 250Hz is a not so fun value. 300 is a lot nicer (multiple of
> both 50Hz and 60Hz and thus covers most TV standards)

Sorry, the ITU-R "M" standard specifies 30000/1001 frames (60000/1001
fields) per second, that's close to 30/60 but not the same. Now please
please don't make use run HZ = (60000/1001 * 5) or similar ;-)

BTW it seems to me that power management using C2/C3 states will work
much more efficiently with a lower HZ because the chipset/processor will
be a larger percentage of the time in c2/c3 mode, right?
