Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129709AbRBZTHF>; Mon, 26 Feb 2001 14:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129711AbRBZTGz>; Mon, 26 Feb 2001 14:06:55 -0500
Received: from host217-32-155-2.hg.mdip.bt.net ([217.32.155.2]:49156 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129709AbRBZTGl>;
	Mon, 26 Feb 2001 14:06:41 -0500
Date: Mon, 26 Feb 2001 19:06:32 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: awe_ram.c
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F12@ftrs1.intranet.ftr.nl>
Message-ID: <Pine.LNX.4.21.0102261901030.995-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hmm, it's a curious driver... Here is the patch (and the final .c) to get
it to compile under 2.4.2

http://www.moses.uklinux.net/patches/aweram/

but the driver doesn't probe for the (extremely frequent!) case when the
device has been prepared by the ISA-PNP subsystem. Looking at the
infrastructure in drivers/net/ne.c it seems doable to teach it the
language of isapnp_find_dev() API -- one just needs to know what
signatures to plug into the ISAPNP_VENDOR() and ISAPNP_FUNCTION() macros
-- my guess is that the output of /proc/isapnp contains this info.

Interesting... I will play with this and see if it detects my ISA-PNP SB
AWE64 card. Give the above patch a try and see if you figure out the
values to plug in there sooner than I do.

Regards,
Tigran

