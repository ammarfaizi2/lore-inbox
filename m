Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVGPHYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVGPHYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 03:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbVGPHYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 03:24:43 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:9181 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262183AbVGPHYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 03:24:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=XhyhR3y8/nBMJ8Oc4yttm/psGt9b07GK/ice+Ut3lKzgy0sdhq4cXbchPY7sRFmPB5+cofmSGdwbwh3bU7Sl/mxDUVth89+vITonlCuk5LMowaY09VzVAtllhO29rK04Cpi6sQAUxLnDaGlfacwMGHKBufkA5qh2x6i55mMDO4M=
Subject: BUG (?) in bridge-netfilter?
From: Hetfield <hetfield666@gmail.com>
Reply-To: hetfield666@gmail.com
To: Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 09:24:27 +0200
Message-Id: <1121498667.15384.5.camel@blight.blightgroup>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i have a very strange bug on my system.
i have 2 3com ethernet cards, bridged.
I wrote some iptable rules on the bridge interface, and they work
perfectly, all but one!

i've this rule in a bash script, starting when a ppp0 connection starts

IPT=iptables
$IPT -A INPUT -s 172.16.92.101 -p icmp --icmp-type echo-request -m limit
--limit 1/s -j ACCEPT
$IPT -A FORWARD -s 172.16.92.101 -p icmp --icmp-type echo-request -m
limit --limit 1/s -j ACCEPT
$IPT -A INPUT -s 172.16.92.102 -p icmp --icmp-type echo-request -m limit
--limit 1/s -j ACCEPT
$IPT -A FORWARD -s 172.16.92.102 -p icmp --icmp-type echo-request -m
limit --limit 1/s -j ACCEPT

it seems not to work.

but if i destroy completly my tables and manually restart the script it
works!!
i'm using 2.6.13-rc3 and iptables 1.3.2, but i got this problem with
2.6.11 and .12 too 
and with iptables 1.2.x

what's wrong?


