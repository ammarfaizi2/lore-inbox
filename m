Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVCBXnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVCBXnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVCBXkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:40:05 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:8003 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261346AbVCBXgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:36:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=JStVmvNnvVhDuVbkZOvsuUArGx0gT6E9n1EyHhnZO09ZdkNCRKR2D0E5nBCSRJb93DeY4trtTowFZbJsbvai5G2K9R3qNlP0ezehascSio4nDnAA8jme34DZV+eiRV7UN7oDYrZn/eApvpv7ALcU0bV31JTmAUqHoSV7QipQ30I=
Message-ID: <d120d500050302153615c76a64@mail.gmail.com>
Date: Wed, 2 Mar 2005 18:36:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Marcus Furlong <furlongm@hotmail.com>
Subject: Re: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150 (and 5150)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY20-F36510468D55048A77ABE9EC95A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <BAY20-F36510468D55048A77ABE9EC95A0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 23:16:43 +0000, Marcus Furlong <furlongm@hotmail.com> wrote:
> Here's the diff of dmesgs between 2.6.10 and 2.6.11
> 
> 2.6.10
> >i8042.c: Warning: Keylock active.
> >serio: i8042 AUX port at 0x60,0x64 irq 12
> >serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> 2.6.11
> < ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
> < ACPI: PS/2 Mouse Controller [PS2M] at irq 12
> < i8042.c: Can't read CTR while initializing i8042.
> 

Your BIOS reports incorrect ports for the keyboard controller, should
be 0x60, 0x64. You will have to boot with i8042.noacpi for now.

-- 
Dmitry

        -- Is there anything else I can contribute?
        -- The latitude and longtitude of the bios writers current
position, and a ballistic missile. (Alan Cox)
