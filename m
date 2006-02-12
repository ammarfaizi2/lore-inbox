Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWBLVtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWBLVtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWBLVtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:49:09 -0500
Received: from khc.piap.pl ([195.187.100.11]:64516 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751470AbWBLVtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:49:08 -0500
To: Olivier Galibert <galibert@pobox.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
	<20060125181847.b8ca4ceb.grundig@teleline.es>
	<20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
	<878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com>
	<20060210235654.GA22512@kroah.com>
	<20060212120450.GA93069@dspnet.fr.eu.org>
	<20060212164633.GA2941@kroah.com>
	<20060212211406.GA48606@dspnet.fr.eu.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 12 Feb 2006 22:49:00 +0100
In-Reply-To: <20060212211406.GA48606@dspnet.fr.eu.org> (Olivier Galibert's message of "Sun, 12 Feb 2006 22:14:06 +0100")
Message-ID: <m34q34l037.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert <galibert@pobox.com> writes:

>> No.  Why would it when it is very simple to query udevinfo for that?
>
> In order not to depend on a userland package for the kernel service of
> device enumeration?  It's udevinfo now, what will it be in two years?

Come on, kernel does not need that info at all. In fact, cdrecord
doesn't need it either. Some frontends, maybe, though hal may be
better source if running.

In fact udev isn't mandatory either. We have it because it's handy,
it saves us from megatons of /dev files and keeps /dev/black-dvd in
sync with black dvd.

Personally I think the whole "cdrecord -scanbus" is bogus - command
line utils should do what they are asked to do (e.g., write to
/dev/hda1 or /dev/microcode if so requested).
-- 
Krzysztof Halasa
