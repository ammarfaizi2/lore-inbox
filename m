Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263416AbTDGNHz (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTDGNHz (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:07:55 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:35081 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263416AbTDGNHy (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 09:07:54 -0400
Date: Mon, 7 Apr 2003 15:19:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andreas Schwab <schwab@suse.de>
cc: Olivier Galibert <galibert@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new syscall: flink
In-Reply-To: <je8yumo4by.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.44.0304071511010.12110-100000@serv>
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org>
 <b6qruf$elf$1@cesium.transmeta.com> <b6r9cv$jof$1@news.cistron.nl>
 <20030407081800.GA48052@dspnet.fr.eu.org> <20030407043555.G13397@devserv.devel.redhat.com>
 <20030407091120.GA50075@dspnet.fr.eu.org> <Pine.LNX.4.44.0304071422580.12110-100000@serv>
 <je8yumo4by.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 7 Apr 2003, Andreas Schwab wrote:

> |> I wouldn't rely on this functionality, not all filesystems might like it 
> |> to have to recreate a deleted fs entry. Most filesystems should be able to 
> |> do this, but all fs drivers have to be checked, that they do the right 
> |> thing.
> 
> All filesystems already have to cope with unlinking of an open file
> anyway, so relinking should not be a problem.

I know, but creating a new dir entry and linking to an existing dir entry 
is not always the same, e.g. filesystems, where a dir entry is not simply 
a pointer to an inode table, have to update other entries as well to 
create a new link. So far filesystems could assume that source dentry was 
a valid dir entry, this patch changes this.

bye, Roman

