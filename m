Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292338AbSBYW0p>; Mon, 25 Feb 2002 17:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292354AbSBYWZh>; Mon, 25 Feb 2002 17:25:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292350AbSBYWY1>; Mon, 25 Feb 2002 17:24:27 -0500
Subject: Re: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18?
To: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Date: Mon, 25 Feb 2002 22:39:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2871.1014671286@nice.ram.loc> from "Raphael Manfredi" at Feb 25, 2002 10:08:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fTly-0006Va-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> to verify what the kernel has set, I read TWICE as much the amount used
> for the set.  That is, if I set 8192, I read 16384.  Therefore, to set
> the correct size, I need to half the parameter first.
> Is this a known bug?  Is it setsockopt or getsockopt which returns the
> wrong size?

Neither. You asked for 8K the kernel allows a bit more for BSD compatibility
and other things. You query and it gives back the size it chose
