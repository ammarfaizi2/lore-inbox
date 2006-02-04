Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWBDPfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWBDPfz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 10:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWBDPfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 10:35:55 -0500
Received: from khc.piap.pl ([195.187.100.11]:33804 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932318AbWBDPfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 10:35:54 -0500
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
	<787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
	<Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
	<20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner>
	<787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
	<43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo>
	<20060203180421.GA57965@dspnet.fr.eu.org>
	<20060203183719.GB11241@voodoo>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 04 Feb 2006 16:35:47 +0100
In-Reply-To: <20060203183719.GB11241@voodoo> (Jim Crilly's message of "Fri, 3 Feb 2006 13:37:19 -0500")
Message-ID: <m3u0bfdtm4.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> writes:

> It's not about device discovery, hald is polling removable devices every 2s
> to see if new media was inserted and when it polls a CD drive that's
> currently burning a disc it causes problems. It's documented in Debian bug
> #262678.

Ok. So what's wrong with cdrecord using O_EXCL (and maybe retrying
for few seconds) so no other program (hald or, say, a user mistaking
a device) can interrupt it?

And, if we are here, what's wrong with hald using O_EXCL to not
interrupt any other program (does hald need to check the media
if it's in use)? I assume the problem wouldn't exist with hald
using O_EXCL and cdrecord not (yet) using it, would it?
-- 
Krzysztof Halasa
