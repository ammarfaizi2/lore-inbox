Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSKCDCo>; Sat, 2 Nov 2002 22:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSKCDCo>; Sat, 2 Nov 2002 22:02:44 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:17668 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261568AbSKCDCo>; Sat, 2 Nov 2002 22:02:44 -0500
Date: Sun, 3 Nov 2002 03:09:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021103030909.A11401@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	=?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com> <20021102232836.GD731@gallifrey> <200211030943.13730.neroz@iinet.net.au> <Pine.LNX.4.44.0211030052410.13258-100000@serv> <20021103000641.GA5284@werewolf.able.es> <1036287009.18289.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1036287009.18289.5.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Nov 03, 2002 at 01:30:09AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 01:30:09AM +0000, Alan Cox wrote:
> On Sun, 2002-11-03 at 00:06, J.A. Magallón wrote:
> > As I see it, the onle thing that should be included in a standard kernel
> > would be something like a kconfig-xaw, that is sure to be on every box that
> > has X, and could be a reference implementation.
> 
> Lots of people no longer include Xaw either nowdays 8)
> 
> Probably the easiest way to do this would be to move the GUI tools out
> of the kernel (or maybe leave the common useful ones) and have make
> guiconfig do
> 
> 	if [ -f /usr/sbin/kernel-gui-config ] ; then
> 		/usr/sbin/kernel-gui-config
> 	elif got_qt() ; then
> 		qt config
> 	elif got_gtk() ; then
> 		gtk_config
> 	else
> 		warnign message
> 		make config
> 	fi

Why does the kernel have to know about that tools at all?  Just put them
into $PATH and let people just call $FOOCONFIG.  This works pretty well
with mconfig on 2.2/2.4..

