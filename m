Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTEEWc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTEEWc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:32:59 -0400
Received: from [217.157.19.70] ([217.157.19.70]:62736 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S261489AbTEEWc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:32:58 -0400
Date: Tue, 6 May 2003 00:45:26 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Halil Demirezen <nitrium@bilmuh.ege.edu.tr>
cc: linux-kernel@vger.kernel.org
Subject: Re: about bios
In-Reply-To: <20030505225013.GA5375@bilmuh.ege.edu.tr>
Message-ID: <Pine.LNX.4.40.0305060041550.7106-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Halil,

On Tue, 6 May 2003, Halil Demirezen wrote:

> I entered bios and disabled FDC and expected to linux
> work still well with floppy, that is fd0.
>
> I thought that linux is not dependent on bios for using
> fdc, hdc, and other things. I want to know how linux uses bios.
>
> does linux still depends on bios thing?

No, it does not, but the floppy driver (drivers/block/floppy.c) looks at
certain hardcoded IO addresses to see if there is a floppy controller or
not.

What you do in the BIOS does not only disable the BIOS calls for the
floppy controller, it turns it completely off in the chipset (software
disconnect) so it is never accessed with the IO access, and therefore is
not detected.

It would probably be possible to turn it on again in floppy.c, but it
would be chipset dependent how to do it.

Cheers,
Thomas

