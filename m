Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVIOVjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVIOVjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbVIOVjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:39:19 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:18994 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964800AbVIOVjS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:39:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nDCdWkqpnpJ0L5HizAf/yC5GbKEm29F3nUwnscF3IkPbracZKAbMqDtBI+1ljC9g7N2iJA2YsTlPT3zNqlsklfe66LPw2yAqHHsSE8psQXnhtmtunUk5uTPYm69UjemvNUoXJHT2Rl3SsOknSdddZhB++4VSpHQM6ETHlcKcl7s=
Message-ID: <d120d500050915143960b43824@mail.gmail.com>
Date: Thu, 15 Sep 2005 16:39:15 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Piter Punk <piterpk@terra.com.br>
Subject: Re: Problems with PS2 mouse
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4329E7CE.4000100@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4329E7CE.4000100@terra.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Piter Punk <piterpk@terra.com.br> wrote:
> PCI: Found IRQ 12 for device 00:07.2
> PCI: Sharing IRQ 12 with 00:07.3
> uhci.c: USB UHCI at I/O 0xd400, IRQ 12
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Found IRQ 12 for device 00:07.3
> PCI: Sharing IRQ 12 with 00:07.2
> uhci.c: USB UHCI at I/O 0xd800, IRQ 12
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected

Hmm, your USB controllers hop onto IRQ12, I don't think mouse will
like it. Does the same happen with 2.6.13? Could you post boot log for
it as well? Also, when booting 2.6.13 you might want to add
"usb-handoff" to the kernel boot line.

-- 
Dmitry
