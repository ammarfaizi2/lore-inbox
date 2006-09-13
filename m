Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWIMOHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWIMOHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWIMOHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:07:06 -0400
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:9677 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1750823AbWIMOHD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:07:03 -0400
Date: Wed, 13 Sep 2006 15:06:39 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: greg@kroah.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] LCD Display Driver lcddisplay, ks0108, cfag12864b
Message-ID: <20060913140639.GA26265@home.fluff.org>
References: <20060912193212.1407209b.maxextreme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912193212.1407209b.maxextreme@gmail.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there would be a case for splitting the lcd
drivers into two layers, one to deal with the hardware
talking to an lcd device (such as an parallel port)
and the second to deal with the command sequences
being sent.

For instance, we have two boards based on ARM which
use a CPLD to decode CS1 and CS2, etc. This would
mean re-writing your driver (and anyone elses)
depending on what sort of LCD we would like to
connect to these.

If there was an generic device driver, then you
could export the writing of bytes to user-space
and have them use the hardware to do any protocol
they liked.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
