Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270444AbTHBXF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 19:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270445AbTHBXF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 19:05:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:50450 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270444AbTHBXF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 19:05:56 -0400
Date: Sun, 3 Aug 2003 01:05:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       comedi@comedi.org
Subject: Re: compiling external kernel modules (comedi.org)
Message-ID: <20030802230553.GA1188@mars.ravnborg.org>
Mail-Followup-To: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	comedi@comedi.org
References: <3F2B0E06.9000907@cn.stir.ac.uk> <20030802070422.GA2404@mars.ravnborg.org> <3F2BA623.6030906@cn.stir.ac.uk> <20030802120756.GA964@mars.ravnborg.org> <3F2BB840.9060205@cn.stir.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2BB840.9060205@cn.stir.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 02:10:24PM +0100, Bernd Porr wrote:
> Sam,
> 
> how can I include the "legal way" includes for comedi? Just now comedi 
> has set up a "linux/include" path in its directory but I think this not 
> the elegant way and it also dosn't work right now.
I have not tried this, but specifying the include path relative to the
directory where the .c file is placed should do the trick.
So if you have:
comedi/
include/
And execute "make -C ...." within the comedi/ directory, the statement:
EXTRA_CFLAGS := -I$(obj)/../include
in the Makefile should do the trick.

> /Bernd
> P.S.: I'm subscribed...
But I'm not - getting these:

Subject: Your message to comedi awaits moderator approval

My point was not to cc: the comedi ML, since potential repliers (like me)
get these kind of replies.

	Sam
