Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269514AbTHJOMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbTHJOMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:12:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:53773 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S269514AbTHJOMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:12:07 -0400
Date: Sun, 10 Aug 2003 16:12:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tom Rini <trini@kernel.crashing.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, <vojtech@suse.cz>
Subject: Re: 2.6.0-test3 issue
In-Reply-To: <20030809191326.GC8475@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.LNX.4.44.0308101523120.714-100000@serv>
References: <20030809191326.GC8475@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 9 Aug 2003, Tom Rini wrote:

> CONFIG_EMBEDDED=n
> CONFIG_SERIO=m
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> 
> The problem is that unless I set CONFIG_EMBEDDED, INPUT_KEYBOARD and
> KEYBOAD_ATKBD both get set to 'Y', regardless of the other dependancies
> (such as SERIO being 'm').

There are multiple possibilities to fix this:

1. change the default of KEYBOARD_ATKBD to SERIO
2. force SERIO to 'y' either via 'select' or EMBEDDED
3. remove the excessive use of EMBEDDED, only INPUT needed fixing, 
everything else had reasonable defaults.

bye, Roman

