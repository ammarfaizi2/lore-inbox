Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293193AbSBWTtV>; Sat, 23 Feb 2002 14:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293192AbSBWTtK>; Sat, 23 Feb 2002 14:49:10 -0500
Received: from petkele.almamedia.fi ([194.215.205.158]:904 "HELO
	petkele.almamedia.fi") by vger.kernel.org with SMTP
	id <S293193AbSBWTsy>; Sat, 23 Feb 2002 14:48:54 -0500
Message-ID: <3C77F1EC.27B32446@pp.inet.fi>
Date: Sat, 23 Feb 2002 21:47:56 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mailerror@hushmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: loop under 2.2.20 - relative block support?
In-Reply-To: <200202230132.g1N1WYJ27596@mailserver2.hushmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mailerror@hushmail.com wrote:
> What exactly is the status of the loopback device in 2.2.20 with regards
> to relative block support? Is it *really* supported?
> 
> The reason I am asking is that I've run into trouble retrieving data off
> of a loopback file after I switched to a new machine. I was using loopback
> in combination with the kerneli patch to mount an encrypted filesystem
> and backup my data to it for safe transport to another machine. The
> decryption seems to be largely successful, since I am able to see most of
> the data when peering at the decrypted file using a hexeditor.

Kerneli patches use block size dependant IV computation (also called "time
bomb" IV). Shit hits the fan when you move files to a device with different
block size. Search linux-crypto archives for more information.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
