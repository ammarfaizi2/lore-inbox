Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264296AbUFTFcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUFTFcL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 01:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbUFTFcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 01:32:05 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:41108 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264296AbUFTFa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 01:30:56 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 6/11] serio dynamic allocation
Date: Sun, 20 Jun 2004 00:30:53 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, vojtech@ucw.cz
References: <200406180335.52843.dtor_core@ameritech.net> <200406180340.55615.dtor_core@ameritech.net> <20040619220700.08425715.akpm@osdl.org>
In-Reply-To: <20040619220700.08425715.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406200030.53331.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 June 2004 12:07 am, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> 
> I8042_KBD_IRQ is not a constant on sparc64.

Yes, what you see are leftovers from me missing that fact... 

> 
> It seems that simply removing that static initialiser will fix
> it up, but I assume it was added for some reason, so I'll leave
> you to ponder that.
> 

No, removing the initialization is the correct way to fix it. We can
only assign these values after platform init is done.

Sorry about the breakage.

-- 
Dmitry
