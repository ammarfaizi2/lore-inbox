Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbUAZAJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 19:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUAZAJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 19:09:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:35295 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265367AbUAZAJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 19:09:33 -0500
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Hugang <hugang@soulinfo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040125190832.619e3225@jack.colino.net>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
	 <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost>
	 <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost>
	 <1074912854.834.61.camel@gaston> <20040124172800.43495cf3@jack.colino.net>
	 <1074988008.1262.125.camel@gaston>
	 <20040125190832.619e3225@jack.colino.net>
Content-Type: text/plain
Message-Id: <1075075706.848.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Jan 2004 11:08:27 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks - I wasn't sure about it.
> The kernel now builds. However, after doing
> 	echo disk > /sys/power/state
> or "hda14" or "/dev/hda14" (which is my swap partition) instead of "disk",
> nothing happens (and nothing gets logged).

Hrm... It tends to do that when it's not happy with something,
but I did get it working... Ah yes, do

echo -n "disk" instead :) It doesn't like the trailing \n

Ben.


