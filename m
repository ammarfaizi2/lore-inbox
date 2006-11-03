Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753376AbWKCQyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbWKCQyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbWKCQyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:54:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:61437 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1753376AbWKCQyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:54:04 -0500
Date: Fri, 3 Nov 2006 17:57:30 +0100
From: chris friedhoff <chris@friedhoff.org>
To: serue@us.ibm.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-Id: <20061103175730.87f55ff8.chris@friedhoff.org>
Reply-To: 20060906182719.GB24670@sergelap.austin.ibm.com
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9d7f00276fac4b25ba506f26988c1e36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch applies cleanly , compiles and runs smoothly against 2.6.18.1.

I'm running slackware-current with a 2.6.18.1 kernel on an ext3
filesystem.

Background why I use the patch:
With 2.6.18 to create a tuntap interface CAP_NET_ADMIN is required.
Qemu uses tuntap to create a tap interface as a virtual net interface.
Instead now running qemu with root privileges to give it the right
to create a tap interface, i granted qemu with the help of the patch and
Kaigai Kohei's userspace tools the cap-net_admin capability. So qemu
runs again without root privilege but has now the right to create the
tap interface.

Thanks for the patch. It reduces my the need of suid-bit progs.
It should be given a spin in -mm.

I will document my experiences on http://www.friedhoff.org/fscaps.html


Chris

please cc me on my email-address

--------------------
Chris Friedhoff
chris@friedhoff.org
