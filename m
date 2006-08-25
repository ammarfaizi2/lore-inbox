Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWHYPCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWHYPCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWHYPCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:02:07 -0400
Received: from smarthost1.sentex.ca ([64.7.153.18]:25569 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S964826AbWHYPCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:02:03 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>
Cc: "'David Woodhouse'" <dwmw2@infradead.org>, <linux-serial@vger.kernel.org>,
       "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 11:01:38 -0400
Organization: Connect Tech Inc.
Message-ID: <043201c6c857$5ddd6c20$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1156441293.3007.184.camel@localhost.localdomain>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Alan Cox
> At this point I think we need
> 
> -	An ioctl to set/get the actual baud rate input/output
> -	Some kind of termios flag to indicate they are being 
> used (as we have
> CBAUDEX now). [We could "borrow" the 4Mbit one and dual use it IMHO]
> 
> For drivers tty_get_baud_rate would return the actual speed as before.
> 
> We would need a driver ->set_speed method for the cases where
> - ioctl is called to set specific board rate
> - OR termios values for tty speed change
> - While we are at it we might want to make ->set_termios also 
> allowed to fail
> 
> [and if you had no ->set_speed method non standard speeds would be
> refused by the tty layer for back compat]
> 
> Anyone got any problems with this before I go and implement it ?

Sounds good.

..Stu

