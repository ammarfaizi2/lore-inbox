Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSKCBCi>; Sat, 2 Nov 2002 20:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbSKCBCi>; Sat, 2 Nov 2002 20:02:38 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:57227 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261549AbSKCBCh> convert rfc822-to-8bit; Sat, 2 Nov 2002 20:02:37 -0500
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@able.es>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021103000641.GA5284@werewolf.able.es>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com>
	<20021102232836.GD731@gallifrey> <200211030943.13730.neroz@iinet.net.au>
	<Pine.LNX.4.44.0211030052410.13258-100000@serv> 
	<20021103000641.GA5284@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 01:30:09 +0000
Message-Id: <1036287009.18289.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 00:06, J.A. Magallón wrote:
> As I see it, the onle thing that should be included in a standard kernel
> would be something like a kconfig-xaw, that is sure to be on every box that
> has X, and could be a reference implementation.

Lots of people no longer include Xaw either nowdays 8)

Probably the easiest way to do this would be to move the GUI tools out
of the kernel (or maybe leave the common useful ones) and have make
guiconfig do

	if [ -f /usr/sbin/kernel-gui-config ] ; then
		/usr/sbin/kernel-gui-config
	elif got_qt() ; then
		qt config
	elif got_gtk() ; then
		gtk_config
	else
		warnign message
		make config
	fi


