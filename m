Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271108AbTHLUqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbTHLUqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:46:47 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:44948 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S271108AbTHLUql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:46:41 -0400
Date: Tue, 12 Aug 2003 22:46:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pete Zaitcev <zaitcev@redhat.com>, Chris Heath <chris@heathens.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 problem
Message-ID: <20030812204625.GB23011@ucw.cz>
References: <20030728155118.GA1761@win.tue.nl> <Pine.GSO.3.96.1030729192558.10528A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030729192558.10528A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 08:29:01PM +0200, Maciej W. Rozycki wrote:
 
>  Nice joke, but I'll answer seriously.  No support was provided.  Hooking
> a PC/XT keyboard to the 8042, if supported, requires a different setup of
> the command byte and is possibly done by the system firmware.  You can
> read the command byte to see which configuration is used.
> 
>  Wrt polling vs IRQ-driven probing and setup: using IRQ is a natural
> choice as you have to do keyboard detection in the IRQ handler anyway to
> properly support hot plugging of a PC/AT or a PS/2 keyboard. 

The only problem there is that it results in a damn complex state
machine. Look at the PS/2 mouse probing and imagine how the state
machine would look.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
