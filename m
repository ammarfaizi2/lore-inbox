Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272251AbTHRS2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272252AbTHRS2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:28:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39186 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272251AbTHRS2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:28:35 -0400
Date: Mon, 18 Aug 2003 19:28:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
Message-ID: <20030818192831.E1737@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030818180941.GJ24693@gtf.org> <Pine.LNX.4.44.0308181117540.5929-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308181117540.5929-100000@home.osdl.org>; from torvalds@osdl.org on Mon, Aug 18, 2003 at 11:21:07AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 11:21:07AM -0700, Linus Torvalds wrote:
> Having done a few serial drivers (not because I want to, but because 
> nobody else seems to be doing them), I definitely see the need for both. 

Of course, the more correct approach is for someone to convert them to
use the new serial driver core (and fix the driver core interface to
allow them to work with it.)

Unfortunately I don't have the hardware for a lot of these specialist
serial cards, so it's a job I've steared clear of.  I've been hoping
that leaving them broken will make the ones which are used stand out,
and hopefully someone with the hardware would've picked them up and
done the necessary conversion.

But alas no.

(I did my best to convert dz.c without the hardware, but it seems to
have been lost into the depths of the MIPS tree... *hint*)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

