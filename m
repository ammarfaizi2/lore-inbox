Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310139AbSCXQfJ>; Sun, 24 Mar 2002 11:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310154AbSCXQe7>; Sun, 24 Mar 2002 11:34:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16911 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310139AbSCXQes>; Sun, 24 Mar 2002 11:34:48 -0500
Subject: Re: Few kernel 2.4.18 problems with high ram
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Sun, 24 Mar 2002 16:50:48 +0000 (GMT)
Cc: ace@credit.com (Eugene Chupkin), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <200203241135.g2OBZ9X18353@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at Mar 24, 2002 01:34:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pBCi-0006fa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stupid rule. I wonder who invented it?

Early 2.4 required it due to a flawed design decision in the VM, that is 
fixed in the rmap VM at least and I think in the base VM by 2.4.18

> If 16 gb is not enough for you, estimate how much mem all your apps and 
> daemons will need in a worst case, then use:
> 
> swap = total_needed_worst_case - ram

Not quite   remember its  (ram - whatever the kernel needs). Its quite
feasible to run with no swap. With current -ac trees (latest 19pre3-ac
series) you can check /proc/meminfo and Committed_AS is your worst case
swap usage assuming the kernel ate all of RAM.

Alan

