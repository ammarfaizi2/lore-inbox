Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTDIUBd (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTDIUBc (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:01:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:46737 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263763AbTDIUAz (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:00:55 -0400
Date: Wed, 09 Apr 2003 13:02:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_INPUT problems
Message-ID: <85360000.1049918540@flay>
In-Reply-To: <Pine.LNX.4.44.0304092154320.5042-100000@serv>
References: <193480000.1049909378@[10.10.2.4]> <Pine.LNX.4.44.0304092154320.5042-100000@serv>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I thought about inverting the logic, and creating CONFIG_HEADLESS
>> which is !CONFIG_INPUT basically ... but changing all the stuff
>> depending on CONFIG_INPUT is rather invasive. So I was thinking of
>> something like
>> 
>> CONFIG_HEADLESS
>> 	bool "headless console support
>> 	default "n"
>> 
>> if HEADLESS = y
>> 	define_bool CONFIG_INPUT = n
>> else
>> 	define_bool CONFIG_INPUT = y
>> endif
> 
> config INPUT
> 	default y if !HEADLESS

I don't see how that'll work ... we already have it defaulting to y,
but there's a previous setting that's 'n' from the 2.4 config file
they're upgrading from ... and that overrides the default, right?

I think in general, that's the right behaviour (else you'd override
your previous settings every time). It's just that in this case, it
creates a serious user problem that we really need to fix. Personally,
I'd be happy to just force it to on all the time, but I suspect that'd
get me lynched ;-)

>> or something vaguely along those lines ... except there doesn't
>> seem to be a way I can see to force a config option on from the
>> new config system? So that's actually a more general question, I guess ;-)
> 
> I know, this has been requested a few times, I hope to have something 
> soon. (It's more a time problem.)

OK, thanks.

M.

