Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966875AbWKYReT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966875AbWKYReT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 12:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966878AbWKYReT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 12:34:19 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:50071 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S966875AbWKYReS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 12:34:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Date: Sat, 25 Nov 2006 18:18:03 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, seife@suse.de
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <20061124234015.GB4782@ucw.cz> <20061125160821.1fd4f9c8@localhost.localdomain>
In-Reply-To: <20061125160821.1fd4f9c8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611251818.04541.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 25 November 2006 17:08, Alan wrote:
> > Hmm... how common are these machines? We are using unpatched kernel
> > for suse10.2... OTOH we only support machines from the whitelist, all
> 
> I've always said IDE and software suspend are unsafe. The more work I do
> the more clearly this is/was the case.
> 
> The really nasty "resume eats your disk" cases I know about are
> thankfully for older systems - VIA KT133 and similar era chipsets.
> There is a recent nasty - Jmicron goes totally to **** on resume because
> of resume quirks not being run but it goes so spectacularly wrong it
> doesn't seem to get far enough to corrupt.
> 
> Lots of other controllers don't work correctly on resume but thats much
> less of a problem and with UDMA misclocking generally turns into a CRC
> error storm and stop.
> 
> Andrew has about 2/3rds of the bits I've done now, will push the rest
> when I've done a little more testing/checking. At that point libata ought
> to be resume safe. Someone who cares about drivers/ide legacy support can
> then copy the work over.

So, it seems we should discourage people from suspending with the old IDE
until someone fixes it.

Perhaps we should update the documentation with this information (?)

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
