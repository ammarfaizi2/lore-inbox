Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUJBVSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUJBVSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUJBVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 17:18:39 -0400
Received: from i-r-genius.demon.co.uk ([80.177.6.225]:21966 "EHLO
	i-r-genius.com") by vger.kernel.org with ESMTP id S267553AbUJBVSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 17:18:38 -0400
From: "Tony Howat" <tony@i-r-genius.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Reading ati_remote keypresses in userland
Date: Sat, 2 Oct 2004 22:18:36 +0100
Message-Id: <20041002211836.M72263@i-r-genius.com>
X-Mailer: Open WebMail 2.30 20040131
X-OriginatingIP: 192.168.1.1 (tony)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The device on /dev/input/event0 says its name is PS/2 Generic Mouse 
> The device on /dev/input/event1 says its name is AT Translated Set 2
> keyboard 
> The device on /dev/input/event2 says its name is X10 Wireless 
> Technology Inc USB Receiver 
> evdev driver version is 1.0.0 
>
> ...but there's no output turning up when I read from the file descriptor. 

Problem solved. Turns out ati_remote was registered twice with input driver, 
so the events were actually turning up on /dev/input/event3 rather that 2. 
Odd.

Thanks to those who helped.

--
Tony

