Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbTL2Uem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbTL2Uem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:34:42 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:9688 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265392AbTL2Udd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:33:33 -0500
Date: Mon, 29 Dec 2003 13:34:48 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Is it safe to ignore UDMA BadCRC errors?
Message-ID: <20031229203448.GD27234@bounceswoosh.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us> <20031229195235.GC26821@bounceswoosh.org> <20031229202432.GA8418@spacken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20031229202432.GA8418@spacken.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29 at 21:24, Florian Schuele wrote:
>i wrote a mail to this list a few days ago.
>i have the same error messages as the above.
>but _only_ with kernel 2.6.0, _not_ with 2.4.20 ...
>thats strange. isnt it?
>after i little traffic on the hd`s the system freezes.

Your error message wasn't the same.

You reported status 0x51 with error code 0x04.  That is the generic
catch-all error message, which usually refers to aborted commands.
Unfortunately, it's tough to know what command the system was
attempting to issue when your drive aborted the command.  There may be
some IDE debugging code you can enable to attempt to find out, but I
don't know exactly how to do that, a linux IDE person will need to
speak up... i'm just a generic IDE person.

The previous poster reported 0x51 with error code 0x80, that is
specifically UDMA CRC errors, and I diagnosed it as such.

--
Eric D. Mudama
edmudama@mail.bounceswoosh.org

