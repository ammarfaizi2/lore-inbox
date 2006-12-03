Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758433AbWLCMyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758433AbWLCMyp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 07:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758446AbWLCMyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 07:54:44 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:24454 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1758349AbWLCMyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 07:54:44 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Date: Sun, 3 Dec 2006 13:49:46 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>
References: <fa.U3NcOE+DHLOUMSq6HkaGglGl7hQ@ifi.uio.no> <200611261113.12826.rjw@sisk.pl> <4569F957.4090100@shaw.ca>
In-Reply-To: <4569F957.4090100@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612031349.47434.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 26 November 2006 21:30, Robert Hancock wrote:
> Rafael J. Wysocki wrote:
> >> btw, I have some code almost ready for sata_nv to add proper 
> >> suspend/resume support. Unfortunately I have trouble testing it, since 
> >> STR doesn't work on my machine since, guess what - the video doesn't 
> >> come back! It doesn't even take the monitor out of standby mode. None of 
> >> the acpi_sleep options seem to work, and vbetool appears to helpfully 
> >> segfault on any operation so that's out.
> > 
> > I guess it's x86-64?  Which version of vbetool?
> 
> Yes, it's x86-64, with whatever version of vbetool comes with Fedora Core 5.
> 
> > 
> >> This is an NVIDIA SLI setup so that probably makes things a bit more
> >> complicated.
> > 
> > Ouch.
> > 
> >> In any case, it should be better than what we have right now for 
> >> suspend/resume support in sata_nv, namely the "do nothing, won't work 
> >> (at least not for CK804 and later)" implementation..
> > 
> > I think I can test it if you send me the patch.
> > 
> > Greetings,
> > Rafael
> 
> Here it is attached. This patch needs to be applied to 2.6.19-rc6-mm1 on 
> top of the other one I just submitted, "[PATCH -mm] sata_nv: fix ATAPI 
> in ADMA mode". I don't think it's too horribly broken since it did what 
> it should have on some aborted suspend-to-disk attempts. (It looks like 
> STD doesn't work either, it complains there is no swap available even 
> though there is.. maybe because there's 2GB of RAM and 2GB of swap? It 
> should still fit though, I would think, as not all RAM is in use..) In 
> any case, if it works out OK then I can submit this formally.

I coudn't test it earlier, sorry.

On top of 2.6.19-rc6-mm2 applies and works (although the box also resumes
just fine without it ;-)).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
