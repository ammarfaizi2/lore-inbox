Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTDITtN (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTDITtN (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:49:13 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:45062 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263742AbTDITtL (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 15:49:11 -0400
Date: Wed, 9 Apr 2003 22:00:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_INPUT problems
In-Reply-To: <193480000.1049909378@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304092154320.5042-100000@serv>
References: <193480000.1049909378@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Apr 2003, Martin J. Bligh wrote:

> What to do ...
> 
> I thought about inverting the logic, and creating CONFIG_HEADLESS
> which is !CONFIG_INPUT basically ... but changing all the stuff
> depending on CONFIG_INPUT is rather invasive. So I was thinking of
> something like
> 
> CONFIG_HEADLESS
> 	bool "headless console support
> 	default "n"
> 
> if HEADLESS = y
> 	define_bool CONFIG_INPUT = n
> else
> 	define_bool CONFIG_INPUT = y
> endif

config INPUT
	default y if !HEADLESS

> or something vaguely along those lines ... except there doesn't
> seem to be a way I can see to force a config option on from the
> new config system? So that's actually a more general question, I guess ;-)

I know, this has been requested a few times, I hope to have something 
soon. (It's more a time problem.)

bye, Roman

