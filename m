Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbTDGPbI (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbTDGPbH (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:31:07 -0400
Received: from smtp03.web.de ([217.72.192.158]:19238 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263511AbTDGPbG (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 11:31:06 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: modifying line state manually on ttyS
Date: Mon, 7 Apr 2003 17:42:27 +0200
User-Agent: KMail/1.5
References: <200304071702.08114.freesoftwaredeveloper@web.de> <1049724987.2965.60.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1049724987.2965.60.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304071742.27972.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 16:16, Alan Cox wrote:
> TxD is a bad choice. A lot of the hardware cannot control TXD this
> way. DTR is the usual one because it is easy to handle but there
> are other control lines you can drive directly (see TIOCGMODEM)

Oh great, you have just discovered the reason, why my driver is working
on my Pentium1-PC but not on my Pentium4-PC. It's simply not supported
by hardware.  I've spent hours and hours about this. :)

My device is actually using DTR and RTS. What line could I use instead of
TxD? Is it possible to use CTS for this, although it is normally a
"input-signal", but not a "output-signal" like RTS?

Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

