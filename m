Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbUFCCfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUFCCfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 22:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265455AbUFCCfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 22:35:41 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:22969 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263020AbUFCCfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 22:35:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: SMP support for swsusp, and strange serio/i8042 problems
Date: Wed, 2 Jun 2004 21:35:36 -0500
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, vojtech@ucw.cz
References: <20040602225549.GA16454@elf.ucw.cz>
In-Reply-To: <20040602225549.GA16454@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406022135.37020.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 05:55 pm, Pavel Machek wrote:
> Why is 8042 marked as system device, btw? 

What should it be? Seems to be a good classification for a KBC...

>                                           Stopping timer for system 
> device is likely useless; first resume is called and only after that
> interrupts are reenabled.
> 

The same routine is used for new and old (APM) style resume where running
timer may prevent system from suspending.

-- 
Dmitry
