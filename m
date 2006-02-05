Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWBEHky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWBEHky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 02:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWBEHky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 02:40:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:50389 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030278AbWBEHkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 02:40:53 -0500
Date: Sun, 5 Feb 2006 08:40:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <m3u0bfdtm4.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.61.0602050838110.6749@yvahk01.tjqt.qr>
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo>
 <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
 <43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo>
 <20060203180421.GA57965@dspnet.fr.eu.org> <20060203183719.GB11241@voodoo>
 <m3u0bfdtm4.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's not about device discovery, hald is polling removable devices every 2s
>> to see if new media was inserted and when it polls a CD drive that's
>> currently burning a disc it causes problems. It's documented in Debian bug
>> #262678.
>
>Ok. So what's wrong with cdrecord using O_EXCL (and maybe retrying
>for few seconds) so no other program (hald or, say, a user mistaking
>a device) can interrupt it?
>
I would say we all forgot to RTFM. Because O_EXCL does nothing *unless* 
O_CREAT is specified, which probably *is not* specified in cdrecord or 
hal. There is no reason to have hal or cdrecord create a device node - 
which you can't do with open() anyway.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
