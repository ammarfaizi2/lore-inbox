Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269503AbUJFVce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269503AbUJFVce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269501AbUJFV2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:28:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:27308 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269467AbUJFV14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:27:56 -0400
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martijn Sipkema <martijn@entmoot.nl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Joris van Rantwijk <joris@eljakim.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <00f201c4abf1$0444c3e0$161b14ac@boromir>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	 <1097080873.29204.57.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0410061955230.7057@eljakim.netsystem.nl>
	 <20041006193053.GC4523@pclin040.win.tue.nl>
	 <1097090625.29707.9.camel@localhost.localdomain>
	 <00f201c4abf1$0444c3e0$161b14ac@boromir>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097094326.29871.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 21:25:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-06 at 23:08, Martijn Sipkema wrote:
> > Nor does anything else in that case. I guess we need a POSIX_ME_HARDER
> > socket option.
> 
> The default should be a POSIX compliant socket IMHO; a POSIX_ME_NOT
> option could provide better performance.

The current setup has so far been found to break one app, after what
three years. It can almost double performance. In this case it is very
much POSIX_ME_HARDER, and perhaps longer term suggests the posix/sus
people should revisit their API design.


