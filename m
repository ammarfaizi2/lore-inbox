Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbSKVLy5>; Fri, 22 Nov 2002 06:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSKVLy5>; Fri, 22 Nov 2002 06:54:57 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:270 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264688AbSKVLyz>; Fri, 22 Nov 2002 06:54:55 -0500
Date: Fri, 22 Nov 2002 13:01:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Nero <neroz@iinet.net.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Qt 3.1 and xconfig
In-Reply-To: <3DDD7CB9.4050001@iinet.net.au>
Message-ID: <Pine.LNX.4.44.0211221257020.2109-100000@serv>
References: <3DDD7CB9.4050001@iinet.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 22 Nov 2002, Nero wrote:

> If you link against qt 3.1 (and this will be common soon, KDE 3.1
> requires it), you can't change any of the options. There is a warning
> when it is running:
> 
> QObject::connect: No such signal ConfigList::menuSelected(struct menu*)
> QObject::connect:  (sender name:   'unnamed')
> QObject::connect:  (receiver name: 'unnamed')
> QObject::connect: No such signal ConfigList::menuSelected(struct menu*)
> QObject::connect:  (sender name:   'unnamed')
> QObject::connect:  (receiver name: 'unnamed')

This is a bug in QT, moc filters the 'struct' keyword from signal 
specification, but connect call doesn't do this. I can work around this, 
but could you please report this also to trolltech?

bye, Roman

