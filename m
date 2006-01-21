Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWAUTnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWAUTnP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWAUTnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:43:15 -0500
Received: from proxy3.nextra.sk ([195.168.1.138]:2311 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751201AbWAUTnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:43:14 -0500
Message-ID: <43D28ECA.7080806@rainbow-software.org>
Date: Sat, 21 Jan 2006 20:43:06 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: isapnp causes "REALTIME operation timeout exceeded" with 2.6.12 and
 newer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
beginning with 2.6.12 (everything older is OK), this started to appear 
during boot (and it's still present in 2.6.15.1):

REALTIME operation timeout exceeded - Switching to normal scheduling
nanosleep failed: Interrupted system call

I tracked it down to "/sbin/isapnp /etc/isapnp.conf"
/sbin/isapnp is from isapnptools-1.26-i386-1.tgz (Slackware-current).
I use /sbin/isapnp to configure my network (3C509) and sound card 
(CMI8329A used as SB16 with sb16 module). It probably causes no problems 
(as both cards work fine) but the error message (and the delay too) is 
annoying.
Does anyone know what can cause this?

-- 
Ondrej Zary
