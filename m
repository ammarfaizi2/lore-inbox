Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSGQRpv>; Wed, 17 Jul 2002 13:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSGQRpv>; Wed, 17 Jul 2002 13:45:51 -0400
Received: from lri.lri.fr ([129.175.15.1]:39602 "EHLO lri.lri.fr")
	by vger.kernel.org with ESMTP id <S316070AbSGQRp3>;
	Wed, 17 Jul 2002 13:45:29 -0400
Date: Wed, 17 Jul 2002 19:34:03 +0200
From: Thomas HERAULT <Thomas.Herault@lri.fr>
To: linux-smp@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sfr@gmx.net
Subject: Bug : 2.4.18, Network and SMP
Message-Id: <20020717193403.63e5f962.Thomas.Herault@lri.fr>
Organization: Laboratoire de Recherche en Informatique (parallelisme)
X-Mailer: Sylpheed version 0.8.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just experienced a similar problem as the one stated in
mail http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.0/0026.html
When subject to heavy load, the tcp/ip stack of 2.4.18 smp kernel seems to
loose some packets. These packets are never sended again by the other
end. Few minutes after the lost of the packets, the recipient of the lost packets
closes the connection. The connection is never closed at the other end (at
least one hour later). 
Compiled without smp support, whatever is the network load, tcp works.
I haven't tested with 2.4.19-rc* or 2.5.*, but I will and let you know if this is 
fixed or not.

If you want any information / further testing, send a mail directly, I'm not on
lkml or smp-ml.

Cheers, Thomas
