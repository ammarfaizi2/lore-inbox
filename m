Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268280AbUHQPO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268280AbUHQPO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUHQPO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:14:58 -0400
Received: from the-village.bc.nu ([81.2.110.252]:26856 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268290AbUHQPOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:14:24 -0400
Subject: Re: Serial Driver for PPP - that runs in Half Duplex Mode
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "vanitha@agilis.st.com.sg" <vanitha@agilis.st.com.sg>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <01C48448.D5B44750.vanitha@agilis.st.com.sg>
References: <01C48448.D5B44750.vanitha@agilis.st.com.sg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092751901.22793.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 Aug 2004 15:11:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-17 at 11:56, Vanitha Ramaswami wrote:
> Do you have a serial port PPP Driver that supports half-duplex mode of 
> operation ?. i.e.  I need RTS to be active when you are transmitting data 
> and to be inactive to receive.

You can do this with a user space helper if performance isnt critical
(ie its not megabits). Create a tty/pty pair. Plug pppd one side of it
and run your own program the other side between it and the real tty.

This is how the old scarabd radio driver worked, although not using PPP
because we found that with the losses we got on radio other protocols
worked better.

