Return-Path: <linux-kernel-owner+w=401wt.eu-S1751662AbXANUQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbXANUQL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 15:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbXANUQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 15:16:11 -0500
Received: from mail.cbxnet.de ([212.87.33.16]:38568 "EHLO mail1.combox.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbXANUQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 15:16:10 -0500
X-Greylist: delayed 2777 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 15:16:10 EST
Subject: incorrect TCP checksum on sent TCP-MD5 packets (2.6.20-rc5)
From: Torsten Luettgert <t.luettgert@pressestimmen.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 14 Jan 2007 20:32:34 +0100
Message-Id: <1168803154.3090.45.camel@elida.cbxnet.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the new TCP-MD5 option in 2.6.20-rc4 and rc5
to talk BGP to cisco routers.
My box connects to the cisco, and the handshake looks fine:
SYN, SYN/ACK, ACK all have md5 option and correct TCP checksums.

All packets after that, i.e. the ones with payload data,
have wrong TCP checksums, quoth wireshark.
The same happens if the cisco connects: the first, "empty" packet
is ok, packets with payload aren't.

Am I doing something wrong? Or is this a bug?

I'll gladly send tcpdumps if it helps.

Thanks for your help,
Torsten

