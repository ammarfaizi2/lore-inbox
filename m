Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbTLLOPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 09:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTLLOPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:15:24 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:10377 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265201AbTLLOPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 09:15:22 -0500
Date: Fri, 12 Dec 2003 15:15:21 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 ps2 mouse giving corrupt data?
Message-ID: <20031212141521.GA27405@ucw.cz>
References: <200312121236.38692.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312121236.38692.andrew@walrond.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 12:36:38PM +0000, Andrew Walrond wrote:
> I have just switched from l2.4 to 2.6 on my thinkpad, and the mouse does 
> something wierd when I boot into x (kde)
> 
> startx, then wait for everything to load, then move mouse. Mouse goes crazy, 
> menus pop up everywhere as though I were pressing buttons, and after about 3 
> seconds, it all settles down and works perfectly.
> 
> So whats causing this? I 've read about the mouse detection stuff in recent 
> 2.6 giving incorrect resolutions and stuff, but thats doesn't apply here. Its 
> getting a load of bad data.
> 
> A buffer_len load of crud is being provided before the real stuff arrives 
> perhaps?
> 
> Andrew Walrond
> 
> PS For 'mouse' read 'Little Red Nipple' which AFAIK is just a ps2 mouse as far 
> as linux is concerned. Worked for 2.4 anyway.

Most likely X does something nasty to the keyboard controller while it
is starting up. The psmouse kernel driver has an autosync feature which
can get it out of trouble if you don't move the mouse for two seconds.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
