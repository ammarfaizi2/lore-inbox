Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270032AbTGXTiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 15:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270034AbTGXTiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 15:38:20 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:12934 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S270032AbTGXTiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 15:38:18 -0400
Date: Thu, 24 Jul 2003 21:53:22 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: John Bradford <john@grabjohn.com>
Cc: rpjday@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: some kernel config menu suggested tweaks
Message-ID: <20030724195322.GA8194@vana.vc.cvut.cz>
References: <200307241910.h6OJAWnm000706@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307241910.h6OJAWnm000706@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 08:10:32PM +0100, John Bradford wrote:
> 
> The filesystem menu, for example, I could previously just skip down in
> make menuconfig, selecting and deselecting what I wanted.  Now, I have
> to go in and out, and in and out, just to see what's selected and
> what's not.  Sure, it might look nice to a new user who doesn't like
> to see a lot of options they don't necessarily understand, but it
> wastes the time of more experienced users.

I think we should use "[X] OptionMenu -->" variant USB Gadgets use
where possible. Currently for example IDE code is

ATA/ATAPI/MFM/RLL support -->
    <*> ATA/ATAPI/MFM/RLL support
    IDE, ATA and ATAPI Block devices -->
        <*> Enhandced IDE/MFM/RLL disk/cdrom/...

One level can be completely removed by doing

<*> ATA/ATAPI/MFF/RLL support -->

directly in toplevel menu. Then you do not have to open most of
the menus, as if there is no checkmark before submenu entry, there is
definitely nothing selected below. 

And after all, there is also "make menuconfig MENUCONFIG_MODE=single_menu".
Unfortunately it starts with all nodes closed, and '*' (which I'm used
to use for unrolling complete subtree) does nothing. And
second problem is that "<*> XXX -->" does not work as expected in
single_menu mode, it still creates its own submenu, which kinda complicates
things.
						Best regards,
							Petr Vandrovec


