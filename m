Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTEIVMo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTEIVMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:12:44 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:63581 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263465AbTEIVMa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:12:30 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200305092109.h49L9TvW023069@post.webmailer.de>
References: <20030507162013$0b67@gated-at.bofh.it>
	 <20030507195008$71e6@gated-at.bofh.it>
	 <20030507224009$4228@gated-at.bofh.it>
	 <20030508140022$2498@gated-at.bofh.it>
	 <20030508193016$1083@gated-at.bofh.it>
	 <20030509182012$49f0@gated-at.bofh.it>
	 <20030509204010$3c9b@gated-at.bofh.it>
	 <200305092109.h49L9TvW023069@post.webmailer.de>
Content-Type: text/plain
Organization: 
Message-Id: <1052515524.2024.17.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 09 May 2003 16:25:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 16:06, Arnd Bergmann wrote:
> Paul Fulghum wrote:
> 
> > One machine (server) was using usb-uhci and
> > the other (laptop) was using usb-ohci.
> > 
> > So it looks like something with USB in 2.5.68-bk11
> 
> The change below was part of 2.5.68-bk11, and adds a 20ms
> delay to the uhci interrupt handler. Could that be
> the culprit?

Possibly, I can try backing out just that part.

To complicate matters, this is happening on 2 machines:
a server and a laptop.

I disabled USB on the laptop (2.5.69) and the problem
is still there :-(

I am confident about these results:
1. On the server, bk10 and earlier works, bk11 and later breaks.
2. On the server, bk11 with USB breaks, bk11 without USB works.
3. On the laptop, 2.5.68 and earlier works, 2.5.69 breaks

I need to test the laptop with the bk10/bk11 sets to
see if this follows the results on the server.

Maybe disabling/enabling USB is just triggering something else
in the configuration file.

I'm leaving for the weekend now, and will try
to get back to this on Monday.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com



-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


