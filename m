Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268461AbTBSNTW>; Wed, 19 Feb 2003 08:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268556AbTBSNTW>; Wed, 19 Feb 2003 08:19:22 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:17939 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268461AbTBSNTV>; Wed, 19 Feb 2003 08:19:21 -0500
Date: Wed, 19 Feb 2003 14:29:15 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2.5.62]: 3/3: Very small menu cleanup
In-Reply-To: <200302181359.37969.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.44.0302191422110.32518-100000@serv>
References: <200302181359.37969.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Feb 2003, Marc-Christian Petersen wrote:

> 1. Move "JBD (ext3) debugging support" two spaces rightwards

Don't do this, indentation is now derived from the dependencies. Adding 
spaces helps 'make config' but not really the other front ends.
The correct fix would be to change JBD into:

config JBD
	bool
	default y
	depends on EXT3_FS

Now the following JBD_DEBUG entry should be an entry under EXT3_FS,
but unfortunately there seems to be bug somewhere, it's inserted to high 
in the menu tree. As a work around you can add EXT3_FS as dependency to 
JBD_DEBUG, I'll look into it as soon as possible.

bye, Roman

