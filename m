Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSIYDxS>; Tue, 24 Sep 2002 23:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261909AbSIYDxS>; Tue, 24 Sep 2002 23:53:18 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:19718
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261908AbSIYDxR>; Tue, 24 Sep 2002 23:53:17 -0400
Date: Tue, 24 Sep 2002 20:57:56 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Richard Zidlicky <rz@linux-m68k.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE janitoring comments
In-Reply-To: <20020924112732.B1060@linux-m68k.org>
Message-ID: <Pine.LNX.4.10.10209242056570.6896-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Switch the transport on the fly for the channel based on the OPCODE.

Easy to say harder to do.

Andre Hedrick
LAD Storage Consulting Group

On Tue, 24 Sep 2002, Richard Zidlicky wrote:

> On Mon, Sep 23, 2002 at 05:28:03PM -0700, Andre Hedrick wrote:
> > 
> > Poke in your own special ide-ops function pointers.
> > This should have been allowed on a per chipset/channel bases.
> 
> I need different transfer functions depending on whether drive
> control data(like IDENT,SMART) or HD sectors are to be transfered. 
> Control data requires byteswapping to correct bus-byteorder
> whereas sector r/w has to be raw for compatibility.
> 
> So that will require 2 additional iops pointers and some change
> in ide_handler_parser or ide_cmd_type_parser to select the
> appropriate version depending on the drive command.
> 
> Richard
> 

