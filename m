Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135403AbRD3Plw>; Mon, 30 Apr 2001 11:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135397AbRD3Plm>; Mon, 30 Apr 2001 11:41:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46210 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135386AbRD3PlZ>; Mon, 30 Apr 2001 11:41:25 -0400
Date: Mon, 30 Apr 2001 11:41:11 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Greg Hosler <hosler@lugs.org.sg>
cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: AC'97 (VT82C686A) & IRQ reassignment (I/O APIC)
In-Reply-To: <XFMail.010430233825.hosler@lugs.org.sg>
Message-ID: <Pine.LNX.3.95.1010430113545.13070A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2001, Greg Hosler wrote:

> The AC'97 has an IRQ register which allows for IRQ's 1, and 3 thru 14
> (page 107 of the VT82C686 datasheet, under section "Offset 3C, Interrupt Line")
> 
> The problem I'm seeing is that on a SMB machine, the IRQ's get reassigned by
> the I/O APIC code, and my AC'97 gets assigned an IRQ of 18 (which won't fit into
> 4 bits :(
> 
> Is there any way to reassign an IRQ to one that teh AC'97 will be happy with ?
> 
> Does any other device already have to do this ?
> 
> thx, and rgds,
> 
> -Greg


Observe that the PCI DWORD (long) register at DWORD offset 15 consists
of 4 byte-wide registers (from the PCI specification), Max_lat, Min_Gnt,
Interrupt pin, and interrupt line.  Nothing has to fit into 4 bits, you
have 8 bits. I haven't looked at the Linux code, but if it provides only 4
bits for the IRQ, it's broken. 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


