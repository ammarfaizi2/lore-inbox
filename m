Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269176AbUJQPMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269176AbUJQPMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 11:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUJQPMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 11:12:35 -0400
Received: from dsl-213-023-002-004.arcor-ip.net ([213.23.2.4]:49162 "EHLO
	be3.lrz.7eggert.dyndns.org") by vger.kernel.org with ESMTP
	id S269164AbUJQPI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 11:08:56 -0400
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Fw: signed kernel modules?
To: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Reply-To: 7eggert@nurfuerspam.de
Date: Sun, 17 Oct 2004 17:13:10 +0200
References: <fa.ghoqtmo.8nqeb0@ifi.uio.no> <fa.jtpibm5.1l4ki17@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1CJCic-0001uC-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> One can make a 'certified' kernel with 'certified' modules
> for some hush-hush project. Adding this kind of junk isn't
> how it's done. You just take your favorite kernel with the
> modules you require, you verify that it meets your security
> requirements, then you CRC the kernel and its modules. You
> keep the CRCs somewhere safe, available from a read-only
> source like a CD/ROM or a network file-server. You automatically
> check these CRCs occasionally using a read-only program on
> read-only source like the network or a CD/ROM. If the checks
> fail, you call the "super" and shut down the system.

If a malicious module loads, you lose instantly. You cannot relaibly check
module integrity on this system anymore. E.g. the malicious module might
patch the module checker to check a signed module instead of the malicious
one. Or the Exploit saves the old module, puts in the patched one, loads it
and puts the old one back in place.

Therefore you have to check on loading the module, independent from the
program loading the module. (Or you'd have to check the program loading the
module and provide a reliable way to prevent any race condition, which
would be much harder.)
-- 
Our last fight was my fault: My wife asked me "What's on the TV?"
I said, "Dust!"

Friﬂ, Spammer: customerservice@innbusbone.com gap@zbanrtq.com
