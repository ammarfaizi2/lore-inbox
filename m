Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUAUNND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 08:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUAUNNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 08:13:02 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:30853 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265433AbUAUNM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 08:12:59 -0500
Date: Wed, 21 Jan 2004 14:13:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.1-mm4
Message-ID: <20040121131302.GA736@ucw.cz>
References: <p73r7xwglgn.fsf@verdi.suse.de> <20040121043608.6E4BB2C0CB@lists.samba.org> <20040121084009.GC295@ucw.cz> <20040121132744.1094129f.ak@suse.de> <20040121123454.GB538@ucw.cz> <20040121134657.6cd27cbd.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121134657.6cd27cbd.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 01:46:57PM +0100, Andi Kleen wrote:

> As for the implementation of doing it at runtime - i took a look at it
> but got scared by sysfs livetime rules and the lack of callbacks in module_parm. 
> I think the easiest way would be to just poll the value: make it a module_parm with the 
> w bit enabled, add a second set of state variables and every time you access 
> the mouse you compare the module_parm variables and the shadow variables and change
> the mouse setting if they differ. Not pretty, but would probably work without
> too much sysfs black magic.

The second problem (after the sysfs magic) is that I'd have to
completely reinitialize the mouse as well, down to the features of the
mouse changing (for example no wheel anymore).

So, it's planned, but don't expect it in 2.6.2.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
