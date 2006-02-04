Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWBDSdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWBDSdk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 13:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWBDSdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 13:33:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27799 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932545AbWBDSdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 13:33:39 -0500
Date: Sat, 4 Feb 2006 19:33:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Krzysztof Halasa <khc@pm.waw.pl>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060204154314.GA18821@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.61.0602041931210.2346@yvahk01.tjqt.qr>
References: <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo>
 <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com>
 <43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo>
 <20060203180421.GA57965@dspnet.fr.eu.org> <20060203183719.GB11241@voodoo>
 <m3u0bfdtm4.fsf@defiant.localdomain> <20060204154314.GA18821@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> And, if we are here, what's wrong with hald using O_EXCL to not
>> interrupt any other program (does hald need to check the media
>> if it's in use)? I assume the problem wouldn't exist with hald
>> using O_EXCL and cdrecord not (yet) using it, would it?
>
>Let me throw in a stupid question: Is O_EXCL cooperative, in that other
>access is only blocked if both tasks use open(...O_EXCL...)?
>
That would be some sort of "shared" what you describe.

O_EXCL basically means that there may only be one file descriptor open on 
it across the whole kernel. "if both tasks" already includes multiple file 
descriptors. (Note that dup() does not really make a new filedescriptor.)


Jan Engelhardt
-- 
