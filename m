Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSIKEsN>; Wed, 11 Sep 2002 00:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSIKEsN>; Wed, 11 Sep 2002 00:48:13 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:14011 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318302AbSIKEsM>; Wed, 11 Sep 2002 00:48:12 -0400
Subject: Re: the userspace side of driverfs
From: Nicholas Miell <nmiell@attbi.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209102122520.1057-100000@cherise.pdx.osdl.net>
References: <Pine.LNX.4.44.0209102122520.1057-100000@cherise.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Sep 2002 21:52:53 -0700
Message-Id: <1031719975.1397.39.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-10 at 21:38, Patrick Mochel wrote:
> 
> On 10 Sep 2002, Nicholas Miell wrote:
> 
> > - The "resource" files export resource structs, however the flags member
> > of the struct uses bits that aren't exported by the kernel and are
> > likely to change in the future. Also, some of the flags bits are
> > reserved for use by the bus that the resource lives on, but the bus type
> > isn't specified by the resource file, which requires the app to parse
> > the path name in order to figure out which bus the resource refers to.
> 
> The flags bit is a good point, and should probably be removed. 
> 

You need the flags, otherwise you can't distinguish dma/irq/mmio/ports.
The other flag bits are interesting, too.

 
- Nicholas

