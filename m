Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWBMPGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWBMPGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWBMPGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:06:24 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:21153 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932123AbWBMPGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:06:24 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 16:04:48 +0100
To: schilling@fokus.fraunhofer.de, jerome.lacoste@gmail.com
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0A010.nailKUSR1CGG5@burner>
References: <20060208162828.GA17534@voodoo>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner>
 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
 <43F06220.nailKUS5D8SL2@burner>
 <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
In-Reply-To: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:

> > The output of cdrecord -scanbus is already parsable,
>
> But it doesn't show the OS specific mapping.
>
> > so what is your point?
>
> I am aiming for a compromise.
>
> My point is that people want to use dev=/dev/hdc in their interface,
> because that's what they are used to. That's a point that I think you
> cannot deny.
>
> If you want to still keep your dev=b,t,l command line interface, just
> let the users know how your mapping is done. That will allow a
> cdrecord wrapper to first query the mapping, then using this mapping
> information and OS specific information (e.g. links) identify the
> b,t,l expected by your interface.
>
> That way you have mostly no code change to do. And you keep your b,t,l
> naming. Everybody is happy.
>
> I've added something like:
>
>                 fprintf(stdout, "%d,%d,%d <= /dev/%s\n",
> 				first_free_schilly_bus, t, l, token[ID_TOKEN_SUBSYSTEM] );
>
> in scsi-linux-ata.c and it does what I want.

The scanbus code was taken from "sformat".

Sformat already includes such a mapping if you are on Solaris.
Unfortunately this does cleanly work on Linux and for this
reason is did not make it into cdrecord.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
