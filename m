Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVA3RTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVA3RTE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVA3RTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:19:03 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:32135 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S261738AbVA3RSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:18:50 -0500
Date: Sun, 30 Jan 2005 18:18:49 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
Message-ID: <20050130171849.GA3354@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I experience the same problems as reported by Michael Gernoth when 
sending a WOL-packet to computer with a e100 NIC which is already 
powered on.

In my case, it's running kernel 2.6.8.1 and the NIC is identified by 
lspci as:
0000:02:08.0 Ethernet controller: Intel Corp. 82562EZ 10/100 Ethernet 
Controller (rev 02)
or numerically:
0000:02:08.0 0200: 8086:1050 (rev 02)

The symptoms is that kacpid starts using all the CPU time it can, a 
shutdown takes 5 - 10 minutes after I've done this (in contrast to 20 - 
30 seconds when the machine is healthy).

Also, if I do a "shutdown -h" on the machine after sending a WOL packet 
when it's already powered up, it will shutdown and immediately start up 
again instead of powering off.

So, any suggestions on how to fix it?

Regards,
David

Please CC me on any replies.
