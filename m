Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261629AbSIXJsE>; Tue, 24 Sep 2002 05:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbSIXJsE>; Tue, 24 Sep 2002 05:48:04 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:28109 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S261629AbSIXJsD>; Tue, 24 Sep 2002 05:48:03 -0400
Date: Tue, 24 Sep 2002 11:27:32 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE janitoring comments
Message-ID: <20020924112732.B1060@linux-m68k.org>
References: <20020924000134.A210@linux-m68k.org> <Pine.LNX.4.10.10209231726580.2072-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10209231726580.2072-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, Sep 23, 2002 at 05:28:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 05:28:03PM -0700, Andre Hedrick wrote:
> 
> Poke in your own special ide-ops function pointers.
> This should have been allowed on a per chipset/channel bases.

I need different transfer functions depending on whether drive
control data(like IDENT,SMART) or HD sectors are to be transfered. 
Control data requires byteswapping to correct bus-byteorder
whereas sector r/w has to be raw for compatibility.

So that will require 2 additional iops pointers and some change
in ide_handler_parser or ide_cmd_type_parser to select the
appropriate version depending on the drive command.

Richard

