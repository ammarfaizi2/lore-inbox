Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbSJDRZo>; Fri, 4 Oct 2002 13:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSJDRZo>; Fri, 4 Oct 2002 13:25:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51204 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262722AbSJDRZn>; Fri, 4 Oct 2002 13:25:43 -0400
Date: Fri, 4 Oct 2002 10:30:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
In-Reply-To: <1033750426.31839.45.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0210041023060.1917-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Oct 2002, Alan Cox wrote:
> 
> Ermm Greg fixed the drivers using it too.

Ehhmm... The patch description says "remove pci_find_device()", which is 
used all over the map and isn't even deprecated (even though it probably 
should be, and people should just register their drivers correctly).

The actual patches themselves actually remove pcibios_find_device(), which
_is_ deprecated. But it's still used in a number of drivers. And no, Greg
did _not_ fix them up - do a simple grep if you don't believe me.

		Linus

