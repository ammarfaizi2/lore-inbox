Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWBWFS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWBWFS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 00:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBWFS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 00:18:26 -0500
Received: from adsl-67-65-14-121.dsl.austtx.swbell.net ([67.65.14.121]:11193
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S1750802AbWBWFS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 00:18:26 -0500
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
From: Michael E Brown <michael_e_brown@Dell.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: mjg59@srcf.ucam.org, akpm@osdl.org, Matt_Domsch@Dell.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060220165353.GD19156@elf.ucw.cz>
References: <35C9A9D68AB3FA4AB63692802656D9EC927875@ausx3mps303.aus.amer.dell.com>
	 <20060220165353.GD19156@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 23:17:39 -0600
Message-Id: <1140671860.19340.66.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 17:53 +0100, Pavel Machek wrote:
> Hi!
> 
> > 	Matthew has shown up on the libsmbios-devel mailing list. I sent
> > all the
> > info needed to do a test of Dell LCD brightness control. The main thing
> > left
> > would be to make one utility out of the current separate, unsupported,
> > test 
> > utils. 
> > 
> > 	As for fixing i8k, I don't have the slightest clue where to
> > begin. You 
> > either have to split initialization with userspace to parse and send in
> > the 
> > correct io/magic ports to do SMI, or you have to put Dell-specific SMI
> > token 
> > parsing in the kernel.
> 
> What is wrong with Dell-specific SMI parsing in kernel? Is it _that_
> much code?
> 

Pavel,
	Sorry for the late response. 

	No, it isn't that much code. You are welcome to rip the parsing from
libsmbios. There are about three or so C structs necessary to parse it.
The total code is probably about 30-40 lines. (see
libraries/token/TokenDA.cpp, and libraries/common/TokenLowLevel.h). 

	My only point is that _everything_ that this module does can now be
completely and fully implemented in userspace using dcdbas and
libsmbios. I'm not against fixing the current i8k code, though. I don't
have the time to submit a patch myself, but would be happy to help any
interested volunteers.
--
Michael

