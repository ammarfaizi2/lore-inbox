Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVCHTSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVCHTSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVCHTOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:14:45 -0500
Received: from arhont4.eclipse.co.uk ([81.168.98.124]:16063 "EHLO
	mail.arhont.com") by vger.kernel.org with ESMTP id S261531AbVCHTJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:09:31 -0500
Message-ID: <422DF866.4050801@arhont.com>
Date: Tue, 08 Mar 2005 19:09:26 +0000
From: "Konstantin V. Gavrilenko" <mlists@arhont.com>
Reply-To: kos@arhont.com
Organization: Arhont Ltd. - Information Security
User-Agent: Mozilla Thunderbird 1.0 (X11/20050205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: racoon@kame.net, linux-kernel@vger.kernel.org
Subject: racoon and usbnet nic = no IPSEC
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

just thought I'd share my experience of last several days.

Had to change the external nic on the gateway box from standard pci device, to a 
usb nic. turned the machine on, everything goes as planned, but no ipsec tunnels 
go up.


Spent couple of days solving the f*^&king problem, tried different kernels 
(2.6.9-2.6.11) and ipsec-tools versions, thought I was going mental.

Only to to find out that my USB Netgear FA-120 would not "work with ipsec".


for some reason, kernel can no create SAs.
Even if you set the tunnels manually, it is still a no go.


The logs are full of:

2005-03-07 15:17:20: ERROR: phase2 negotiation failed due to time up waiting for 
phase1. ESP xxx.xxx.xxx.bbb->xxx.xxx.xxx.aaa
2005-03-07 15:17:20: INFO: delete phase 2 handler.
2005-03-07 15:17:24: ERROR: can't start the quick mode, there is no valid 
ISAKMP-SA, 530bc0362f36f1ed:9673792c0daa890f



Anyone has any suggestions of why this was happening?

I can post more info if developers are interested.


-- 
Respectfully,
Konstantin V. Gavrilenko

Arhont Ltd - Information Security

web:    http://www.arhont.com
	http://www.wi-foo.com
e-mail: k.gavrilenko@arhont.com

tel: +44 (0) 870 44 31337
fax: +44 (0) 117 969 0141

PGP: Key ID - 0x4F3608F7
PGP: Server - keyserver.pgp.com
