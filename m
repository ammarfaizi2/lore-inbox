Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVCVAwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVCVAwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVCVAtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:49:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:46468 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262221AbVCVAtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:49:06 -0500
Subject: Re: Radeonfb blanks the screen / hangs the system with 2.6.11
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Antipov <dmitry.antipov@mail.ru>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <423EA96D.1030201@mail.ru>
References: <423EA96D.1030201@mail.ru>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 11:47:41 +1100
Message-Id: <1111452461.25180.318.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 14:01 +0300, Dmitry Antipov wrote:
> Hello,
> 
> this looks like an issue with radeonfb driver.
> 
> If radeonfb and fb console are built-in, the console blanks and system 
> bootup
> stopped immediately after switching to fb console, and monitor displays 
> "No signal"
> message. C-A-D works, but nothing is logged.
> 
> For modular radeonfb, the console becomes blank after 'modprobe 
> radeonfb'. But the
> rest of the system is fine and console input works, so I can safely 
> reboot the box
> and get log messages at the next boot:
> The host OS is Fedora Core 3. Hardware is:
>  - MB Asus P5GD1
>  - CPU Intel P4 3.2 GHz
>  - Video Asus EAX600XT/HTVD (PCIE)

You mean the card is a PCI Express card ? Hrm... I'm not sure that was
ever tested. I can't tell precisely what's up at this point, the dmesg
looks normal except that the panel appears to be detected twice, but
that's harmless.

> According to http://kerneltrap.org/mailarchive/1/message/28472/thread, 
> I've also
> tried both built-in and modular versions with non-default 'default_dynclk'
> (-1, 0 and 1), but this was a no-op in my case.
> 
> Dmitry
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

