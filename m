Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbULXOM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbULXOM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 09:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbULXOM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 09:12:27 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:24543 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S261381AbULXOMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 09:12:22 -0500
Message-ID: <41CC23C4.4000505@rnl.ist.utl.pt>
Date: Fri, 24 Dec 2004 14:12:20 +0000
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: name resolve problem kernel dependent
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everyone,

I'm having this weird problem with both my laptop and desktop.

when using kernels 2.6.10-rc3 through 2.6.10-rc3-bk15, including mm patches or 
ck patches, not all programs can resolve hostnames.

lynx www.google.pt
fails because it can't resolve the hostname.

host www.google.pt
works.

lynx www.google.pt
fails again. appearently it's not using the same resolve method as host.

I've tried other hostnames and the results are consistent. The solution, I 
found, was to leave only "nameserver" lines in /etc/resolv.conf. weird, I guess, 
but it solves the problem. the resolv.conf is written by the dhcp client and 
it's not wrong, since it worked and other kernels don't have problems.

this doesn't happen with 2.6.9, 2.6.9-ck3, 2.6.9-ac16 kernels. they work ok.

any tips? I can print straces if someone finds them useful.

this is ALLWAYS reproducible. could it be a kernel bug?

regards,
pedro venda.
-- 

Pedro João Lopes Venda
email: pjvenda@rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administração de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior Técnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt
