Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUFTRsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUFTRsf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUFTRr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:47:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52228 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265678AbUFTRoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:44:30 -0400
Date: Sun, 20 Jun 2004 18:44:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Dreher <michael.dreher@uni-konstanz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops eject cardbus 2.6.7
Message-ID: <20040620184424.A641@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Dreher <michael.dreher@uni-konstanz.de>,
	linux-kernel@vger.kernel.org
References: <200406201749.00739.michael.dreher@uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200406201749.00739.michael.dreher@uni-konstanz.de>; from michael.dreher@uni-konstanz.de on Sun, Jun 20, 2004 at 05:49:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 05:49:00PM +0200, Michael Dreher wrote:
> when ejecting a cardbus card, I got the following oops.
> The box is a vaio C1 picturebook, the card is part of a 
> CD-ROM drive. Kernel is 2.6.7.

Known problem - IDE likes to mess about with resources behind the back
of PCMCIA, and with some of the changes which went into 2.6.7, this is
no longer feasible.

However, if I can get enough of my current patch queue merged, then this
problem resolves itself, since we loose the need for IDE to mess with
the resource subsystem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
