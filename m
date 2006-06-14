Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWFNQ5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWFNQ5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWFNQ5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:57:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:25178 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932091AbWFNQ5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:57:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HjXSRzbTBsgSu783fj67+tl8sdIkOSZtExwh/MCXMoZLv5xNCZvXCsBxQz7nk4OlehPpeY7sVD36mUmlmHjOY/xwlKSZFlY+VJTKs3F62xXU/T7tMm4EtVl877OIyJb+x4yuSt+Nlc6K7hE+6Oc5n56RfvdrC8kB1QfuacGML3k=
Message-ID: <6f6293f10606140957t18545deetf3f75bba09eafa3d@mail.gmail.com>
Date: Wed, 14 Jun 2006 18:57:07 +0200
From: "Felipe Alfaro Solana" <felipe.alfaro@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel-level IP autoconfiguration and nodename
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I'm trying to deploy several diskless workstations using Ubuntu
Dapper. I've followed the steps highlighted in the Wiki
https://wiki.ubuntu.com/DisklessUbuntuHowto (plus some additional
modifications to get it working fine).

However, I'm unable to get the client machine get its hostname from
the DHCP server. What is really strange is that the kernel itself is
able to autoconfigure itself using DHCP, and I can see during boot
that a hostname is assigned to the client, as shown before:

IP-Config: eth0 complete (from 10.0.0.2):
 address: 10.0.0.10        broadcast: 10.255.255.255   netmask: 255.0.0.0
 gateway: 10.0.0.2         dns0     : 10.0.0.2         dns1   : 0.0.0.0
 host   : client1
 domain : lan
 rootserver: 10.0.0.2 rootpath:

However, both "uname -n" and hostname return "(none)". I have tried
hacking the initram, but I have been unable to guess why, although the
kernel is receiving a hostname via DHCP, hostname ends up being
"(none)".

I've been reading net/ipv4/ipconfig.c and seems like
system_utsname.nodename is being set to the host name received via
DHCP, but I can't guess why /proc/sys/kernel/hostname keeps returning
"(none)".

Any ideas?

Thank you very much.
