Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267381AbSKPWBh>; Sat, 16 Nov 2002 17:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbSKPWBh>; Sat, 16 Nov 2002 17:01:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:51104 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267381AbSKPWBg>;
	Sat, 16 Nov 2002 17:01:36 -0500
Message-ID: <3DD6C1DC.44966373@digeo.com>
Date: Sat, 16 Nov 2002 14:08:28 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin A <ja6447@albany.edu>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pnpbios oops on boot w/ 2.5.47
References: <200211161700.29653.ja6447@albany.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2002 22:08:28.0621 (UTC) FILETIME=[B13517D0:01C28DBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin A wrote:
> 
> Hi :)
> 
> I tried to "port" kmsgdump to 2.5.47 and for some reason, it worked.
> 
> Attached is the full dmesg
> 
> Alan: I ran dmidecode under 2.4.19 which said simply "PNP BIOS present"
> 
> This is a thinkpad 760e, really old..I don't even think I need pnpbios support
> for anything.  2.5.47/2.5.47-ac5 boot with pnpbios turned off, so I think you
> just need to add this to your blacklist?
> 

The BUG in slab indicates that something overran the end of a kmalloced
buffer.  That'll be either pnp_bios_get_dev_node() or node_set_resources()
ran off the end of `node'.
