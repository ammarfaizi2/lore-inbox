Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSHUDLA>; Tue, 20 Aug 2002 23:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSHUDLA>; Tue, 20 Aug 2002 23:11:00 -0400
Received: from codepoet.org ([166.70.99.138]:12486 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S317755AbSHUDK7>;
	Tue, 20 Aug 2002 23:10:59 -0400
Date: Tue, 20 Aug 2002 21:15:09 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac5 Promise PDC20269
Message-ID: <20020821031509.GA11920@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208201845060.10173-100000@valhalla.homelinux.org> <Pine.LNX.4.10.10208201936000.3867-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10208201936000.3867-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 20, 2002 at 07:40:37PM -0700, Andre Hedrick wrote:
> > hde reduced to Ultra33 mode.
> > hde: host protected area => 1
> > hde: 117266688 sectors (60041 MB) w/1820KiB Cache, CHS=116336/16/63, UDMA(133)

BTW that host protected area message is pretty silly. It gives
the appearance that perhaps the BIOS has issued a SET MAX ADDRESS
when in fact, all the message is doing is enumerating the drive's
capabilities (duplicating what 'hdparm -I' does).  At the
minimum, this message should be changed to something more like:

    printk("%s: host protected area supported: %s\n", 
	    drive->name, (flag==1)? "no" : "yes");

Personally, I think we should lose the message entirely.  If
someone want to know what their drive can do, they can ask
hdparm and get a full listing,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
