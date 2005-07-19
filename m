Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVGSAe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVGSAe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 20:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGSAe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 20:34:27 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:44932 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261851AbVGSAdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 20:33:25 -0400
Message-ID: <42DC4873.2080807@gmail.com>
Date: Tue, 19 Jul 2005 02:25:23 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rth@twiddle.net, dhowells@redhat.com, kumar.gala@freescale.com,
       davem@davemloft.net, mhw@wittsend.com, support@comtrol.com,
       R.E.Wolff@BitWizard.nl, nils@kernelconcepts.de, cjtsai@ali.com.tw,
       Lionel.Bouton@inet6.fr, benh@kernel.crashing.org,
       mchehab@brturbo.com.br, laredo@gnu.org, rbultje@ronald.bitfreak.net,
       middelin@polyware.nl, philb@gnu.org, tim@cyberelk.net,
       campbell@torque.net, andrea@suse.de, linux@advansys.com,
       lnz@dandelion.com, chirag.kantharia@hp.com, mike@i-Connect.Net,
       nils@kernelconcepts.de, mulix@mulix.org
Subject: [PATCH] pci_find_device --> pci_get_device
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is for mixed files from all over the tree.

Kernel version: 2.6.13-rc3-git4

* This patch removes from kernel tree pci_find_device and changes
it with pci_get_device. Next, it adds pci_dev_put, to decrease reference
count of the variable.
* Next, there are some (about 10 or so) gcc warning problems (i. e.
variable may be unitialized) solutions, which were around code with old
pci_find_device.
* Some code was unpretty, or ugly, so the patch provides more readable
code, in some cases.
* Marks the function as deprecated in pci.h

The patch is here, (because of its size -- about 120 KiB):
http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4.patch
and its bzipped version, if you want (about 25 KiB):
http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4.patch.bz2

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

