Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbRHFJwz>; Mon, 6 Aug 2001 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267831AbRHFJwp>; Mon, 6 Aug 2001 05:52:45 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:32264 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267771AbRHFJwl>;
	Mon, 6 Aug 2001 05:52:41 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-pre4, lots of compile warnings 
In-Reply-To: Your message of "Mon, 06 Aug 2001 11:49:10 +0200."
             <Pine.LNX.4.33.0108061138040.9237-100000@vaio> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 19:52:31 +1000
Message-ID: <3334.997091551@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001 11:49:10 +0200 (CEST), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>On Mon, 6 Aug 2001, Keith Owens wrote:
>> drivers/isdn/hisax/config.c:1720: warning: `hisax_pci_tbl' defined but not used
>> drivers/isdn/avmb1/b1pci.c:31: warning: `b1pci_pci_tbl' defined but not used
>> drivers/isdn/avmb1/t1pci.c:34: warning: `t1pci_pci_tbl' defined but not used
>> drivers/isdn/avmb1/c4.c:39: warning: `c4_pci_tbl' defined but not used
>
>I can think of multiple ways to fix this:
>
>o Move drivers to the new pci infrastructure. This is of course the
>  best solution in the long run, but in many cases not appropriate for 
>  2.4.
>o Add an __attribute__((unused)) to the definition of the table. Ugly.

Add attribute unused plus a BIG comment saying that the code should be
moved to the new pci infrastructure ASAP.  Add the code to the janitor
list.

