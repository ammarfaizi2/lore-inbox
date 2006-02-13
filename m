Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWBMGDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWBMGDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 01:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWBMGDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 01:03:30 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:46787 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750902AbWBMGD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 01:03:29 -0500
Message-ID: <43F0216F.1000006@t-online.de>
Date: Mon, 13 Feb 2006 07:04:31 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: hpa@zytor.com
CC: Carlos Carvalho <carlos@fisica.ufpr.br>, linux-kernel@vger.kernel.org
Subject: netboot / nfsroot problems
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: STLdz+ZVoevD5621YwW5eo6OlawzKpP0RDsz3PpAmkFqDkhHEr9KED@t-dialin.net
X-TOI-MSGID: fb200260-a73f-4f7e-84b1-1f7636d0499e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans Peter,

You asked Carlos Carvalho and me if we care to try

    git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

Netbooting does work for me now without any problems, please see

    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0601.3/2128.html and
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0601.3/2322.html

Some time after the last msg netboot stoped to work again, reenabling pio
for the 8139 solved that problem again.

At that time I thought I found an 8139too bug, but the report of Carlos 
shows
that I might have been wrong. Two possibilities remain:

-   Both the 8139 and the Intel NIC drivers are broken in a way that 
allows them
    to work reliably in normal operation, but that prevents them to receive
    ip packets during ip autoconfig.

-   Some code that both these cards use during ip autoconfig is broken.

Netbooting a VIA rhine system worked without any problems, it worked
with _exactly_ the same setups that failed for 8139too.

Do you still believe that our problems could be solved by the code in 
your git
tree? I would have to install git here first, but I will do it if necessary.

I asked Carlos to try to boot with the netconsole code enabled as this 
changes
the nic init and thus _could_ help, unfortunately I received no answer 
up to now.

cu,
 Knut
