Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUKOPFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUKOPFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 10:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUKOPFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 10:05:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24234 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261606AbUKOPFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 10:05:32 -0500
Date: Mon, 15 Nov 2004 16:05:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Blizbor <kernel@globalintech.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 native IPsec implementation question
In-Reply-To: <4198C1A4.8080707@globalintech.pl>
Message-ID: <Pine.LNX.4.53.0411151557550.17812@yvahk01.tjqt.qr>
References: <4198B2B6.9050803@globalintech.pl> <Pine.LNX.4.53.0411151455020.17543@yvahk01.tjqt.qr>
 <4198C1A4.8080707@globalintech.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>These almost exactly are rules I want to implement.
>But, when you run tcpdump -nni eth0 you can see ESP traffic _and_ one
>direction of something going through IPsec.

I think that PF_PACKETs "bypass" the firewall. Don't count on that, though.
(It's because I still see incoming port attempts despite having a tight
-P DROP)

>Moreover "-i eth0 -j DROP" blocks IPsec traffic ... (or -o eth0 i don't
>remember direction)

You "sit" on the network card chip and then think of input and output.
Btw, -j DROP will only drop what has not been matched up to now. So if you get
to -j ACCEPT IPsec traffic beforehand (I think -m ah / -m esp, did not
it?), they will never reach -j DROP.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
