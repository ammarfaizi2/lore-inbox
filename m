Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUH3NJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUH3NJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUH3NJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:09:21 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:41853 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267940AbUH3NJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:09:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PS/2 mouse driver panics during boot - 2.6.8.1
Date: Mon, 30 Aug 2004 08:09:14 -0500
User-Agent: KMail/1.6.2
Cc: Peter Horton <pdh@colonel-panic.org>
References: <20040830115059.GA8907@skeleton-jack>
In-Reply-To: <20040830115059.GA8907@skeleton-jack>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408300809.14671.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 August 2004 06:50 am, Peter Horton wrote:
> Every other time I boot my x86 box the kernel panics in
> psmouse_interrupt() because ->protocol_handler is NULL. Looks like
> psmouse_connect() runs before ->protocol_handler is set and generates an
> interrupt from the mouse. The mouse driver is built in, and I'm not
> passing it any parameters.
> 

Hi, 

That should be fixed when Vojtech pushes next round of input updates
to Linus, in the meantime you can try disabling USB legacy emulation
in BIOS or try building psmouse modular and loading it after all USB
modules.
 
-- 
Dmitry
