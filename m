Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272962AbTHKRn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272951AbTHKRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:43:04 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:14607 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272919AbTHKRkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:40:33 -0400
Date: Mon, 11 Aug 2003 18:40:26 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: mouse and keyboard by default if not embedded
In-Reply-To: <Pine.GSO.4.21.0308101040220.19901-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0308111836100.2275-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  config INPUT_MOUSEDEV_PSAUX
> > -	bool "Provide legacy /dev/psaux device"
> > +	bool "Provide legacy /dev/psaux device" if EMBEDDED
> 
> Now INPUT_MOUSEDEV_PSAUX is always (on non-embedded machines) forced to true,
> even on machines without PS/2 keyboard/mouse hardware. Is that OK?
> 
> So far (compiling, not running 2.6.0-test3) I didn't notice any problems,
> though.

kYes it is fine. That is a PS/2 aux emulator. It turns non PS/2 mice into 
PS/2 mice. Personally I rather have people use the /dev/input/eventX 
interface. That PS/2 hack will go away in the future. 

P.S 
   CONFIG_INPUT_EVDEV is not turned on by default. It should be IMO.


