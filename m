Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130517AbRCWKvU>; Fri, 23 Mar 2001 05:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130523AbRCWKvL>; Fri, 23 Mar 2001 05:51:11 -0500
Received: from mail.inup.com ([194.250.46.226]:7436 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S130517AbRCWKuy>;
	Fri, 23 Mar 2001 05:50:54 -0500
Date: Fri, 23 Mar 2001 11:55:35 +0100
From: christophe barbe <christophe.barbe@lineo.fr>
To: Jun Sun <jsun@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 question: why SCBCmd byte is 0x80?
Message-ID: <20010323115535.A16497@pc8.inup.com>
In-Reply-To: <3ABA68EC.89B2DE99@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ABA68EC.89B2DE99@mvista.com>; from jsun@mvista.com on jeu, mar 22, 2001 at 22:04:45 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which kernel are you using.

I've had a similar problem with 2.2.18.
I've backported 2.2.19pre changes to it. 
(i.e. apply on 2.2.18 a diff of the file drivers/net/eepro100.c made between 2.2.18 and the last 2.2.19pre)
And since I've never seen this problem again.

Christophe

On jeu, 22 mar 2001 22:04:45 Jun Sun wrote:
> 
> I am trying to get netgear card working on a new (read as potentially buggy
> hardware) MIPS board.
> 
> The eepro100 driver basically works fine.  It is just after a little while
> (usually 2 sec to 15 sec) network communication suddenly stops and I start see
> error message like "eepro100: wait_for_cmd_done timeout!".
> 
> I looked into this, and it appears that the SCBCmd byte in the command word
> has value 0x80 instead of the expected 0.  I looked at the Intel manual, and
> it says nothing about the value being 0x80.
> 
> Does anybody have a clue here?  I suspect some timing is wrong or a buggy PCI
> controller.
> 
> Please cc your reply to my email address.  Thanks.
> 
> Jun
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
