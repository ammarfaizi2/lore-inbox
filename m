Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVCML5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVCML5D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 06:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVCML5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 06:57:03 -0500
Received: from aun.it.uu.se ([130.238.12.36]:34291 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261164AbVCML46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 06:56:58 -0500
Date: Sun, 13 Mar 2005 12:56:51 +0100 (MET)
Message-Id: <200503131156.j2DBup8X015801@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: hacksaw@hacksaw.org, linux-kernel@vger.kernel.org
Subject: Re: indirect lcall without `*'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2005 00:46:24 -0500, Hacksaw <hacksaw@hacksaw.org> wrote:
>In compiling 2.4.29 I get this during the compilation of pci-pc.c:
>
>Warning: indirect lcall without `*'
>
>I note from looking around the net that this is an old "problem", dating back 
>at least to 2.4.18, if not earlier.
>
>What does it mean? Should I care? If I shouldn't, shouldn't there be a message 
>somewhere in the build process that says "This isn't a problem" so people 
>don't write to lkml and ask about it?

It's a binutils version issue. Older binutils didn't
require the '*', while newer ones print a warning when
it's missing. Adding the missing '*'s breaks old binutils,
which isn't considered acceptable in the stable 2.4 series.

So just live with the warnings, or apply personal patches
to silence them (like I've been doing for ages).

/Mikael
