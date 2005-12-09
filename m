Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVLIR1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVLIR1X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLIR1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:27:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1553 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932267AbVLIR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:27:22 -0500
Date: Fri, 9 Dec 2005 17:27:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jason Dravet <dravet@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Message-ID: <20051209172717.GC31708@flint.arm.linux.org.uk>
Mail-Followup-To: Jason Dravet <dravet@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <20051208105425.GA28397@flint.arm.linux.org.uk> <BAY103-F33F72FF201DD9A0728D2EBDF450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY103-F33F72FF201DD9A0728D2EBDF450@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 08:37:01AM -0600, Jason Dravet wrote:
> The /etc/inittab file is where I got the number 7 from (6 tty plus 1 
> Xwindows).  I have to change the inittab everytime I install FC since they 
> switched to graphical boot (FC does not like my monitor).  Let me see if I 
> got this right:  Is the reason 64 tty devices exist similiar to the reason 
> you gave me about the 32 serial ports?

I guess so - I don't look after the virtual console stuff.

> You create all the nodes so they 
> can be used at anytime.  If there were only the 6 tty nodes created then if 
> you want to direct your logger to tty12, you would first have to create 
> that node and then tty12 could be used.  If this is true how are the other 
> 52 tty devices accessed?  I don't have a F13 or F44 keys on my keyboard.

There is a key combination, but it's dependent on the keymap.
dumpkeys -f and search for "Console_" - it's in keymap 2 (but
I don't know what activates keymap 2.)

> I like the idea of the patch that Dave Jones created.  The question I have 
> is with all of this plug and play stuff in our PCs shouldn't it be possible 
> to get the correct number of ports, ask the bios or the pci bus or 
> something?

If you're considering only legacy free systems, yes you are probably
right.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
