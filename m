Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUBEOBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUBEOBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:01:32 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:14347 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S265267AbUBEOB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:01:29 -0500
Message-ID: <1075989609.40224c690ea90@imp.gcu.info>
Date: Thu,  5 Feb 2004 15:00:09 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Paulo Sergio Ferreira Borges do Carmo <psfbc@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Temperature above threshold in kernel 2.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.137
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paulo,

Just saw you post on LKML as I was browsing around:

> 2 23:53:03 bobi kernel: CPU#0: Temperature above threshold
> 2 23:53:03 bobi kernel: CPU#0: Running in modulated clock mode
> 2 23:53:03 bobi kernel: CPU#0: Temperature/speed normal
>
> I take a look and found out that the CPU temperature was 91º C,
> after that i shutdown the Laptop and restart the machine with the
> old 2.4.22 kernel.
> Dose 2.6.1 kernel take control of cpu fan ? it is possible to
> delegate fan control to the bios (i think kernel 2.4.x works this
> way right ?)

More likely than not, this is an ACPI issue. I see that you have it
enabled in your 2.6.1 kernel. Do you also have ACPI enabled in your 2.4
kernel? In a more general way, you should look for differences in ACPI
configuration between 2.4 and 2.6.

If there is no difference, I invite you to turn on debugging and
possibly relaxed syntax too. Maybe it'll let you discover something.

Trying 2.6.2 is also an option to consider, since it seems to have many,
many ACPI fixes and improvements.

Hope that helps,

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

