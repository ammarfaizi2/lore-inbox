Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263409AbTDGMTw (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbTDGMTv (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:19:51 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:28422 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S263409AbTDGMTu (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:19:50 -0400
Date: Mon, 7 Apr 2003 14:31:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Olivier Galibert <galibert@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
In-Reply-To: <20030407091120.GA50075@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.44.0304071422580.12110-100000@serv>
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org>
 <b6qruf$elf$1@cesium.transmeta.com> <b6r9cv$jof$1@news.cistron.nl>
 <20030407081800.GA48052@dspnet.fr.eu.org> <20030407043555.G13397@devserv.devel.redhat.com>
 <20030407091120.GA50075@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> That breaks one of the main uses, creating with open a temporary file
> in /tmp, unlinking it, then later hooking it up somewhere else in the
> filesystem.

I wouldn't rely on this functionality, not all filesystems might like it 
to have to recreate a deleted fs entry. Most filesystems should be able to 
do this, but all fs drivers have to be checked, that they do the right 
thing.

bye, Roman

