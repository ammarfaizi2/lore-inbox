Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319135AbSIJORp>; Tue, 10 Sep 2002 10:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319136AbSIJORp>; Tue, 10 Sep 2002 10:17:45 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:31997
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319135AbSIJORo>; Tue, 10 Sep 2002 10:17:44 -0400
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45B36A38D959B44CB032DA427A6E1064012814A8@cceexc18.americas.cpqcorp.net>
References: <45B36A38D959B44CB032DA427A6E1064012814A8@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 15:25:32 +0100
Message-Id: <1031667932.31554.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 15:06, Cameron, Steve wrote:
> We can use the md driver for this.  However, we cannot boot from
> such a multipath device.  Lilo and grub do not understand md multipath
> devices, nor do anaconda or other installers.  (Enhancing all of those,
> I'd like to avoid.  Cramming multipath i/o into the low level driver
> would accomplish that, but, too yucky.) 
> 
> If there is work going on to enhance the multipath support in linux
> it would be nice if you could boot from and install to such devices.

Booting from them is a BIOS matter. If the BIOS can do the block loads
off the multipath device we can do the rest. The probe stuff can be done
in the boot initrd - as some vendors handle raid for example.

