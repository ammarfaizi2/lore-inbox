Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317538AbSHHSXQ>; Thu, 8 Aug 2002 14:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317667AbSHHSXQ>; Thu, 8 Aug 2002 14:23:16 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:29679 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317538AbSHHSXL>; Thu, 8 Aug 2002 14:23:11 -0400
Subject: Re: problems with 1gb ddr memory sticks on linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Bryan K. Walton" <thisisnotmyid@tds.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020808163952.GJ16225@weccusa.org>
References: <20020808160456.GI16225@weccusa.org>
	<1028828840.28883.43.camel@irongate.swansea.linux.org.uk> 
	<20020808163952.GJ16225@weccusa.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 20:46:52 +0100
Message-Id: <1028836012.28883.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 17:39, Bryan K. Walton wrote:
> Dimm slot 1 = 256MB DDR PC2100 and
> Dimm slot 2 = 1024MB DDR PC2100
> 
> and the /proc/mtrr shows:
> 
> casa:~# cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1 

Your BIOS misconfigured the memory control registers. You may find
swapping the DIMMs over fixes that or a BIOS update. If you don't want
to update your BIOS then doing

echo "base=0x00000000 size=0x60000000 type=write-back" >/proc/mtrr

should override the BIOS setting and make your machine speed up.

