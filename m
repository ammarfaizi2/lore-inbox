Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUFQPSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUFQPSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUFQPSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:18:36 -0400
Received: from 140.006.050.210.cust.mel.idc.iprimus.net.au ([210.50.6.140]:30215
	"EHLO bonkers.disegno.com.au") by vger.kernel.org with ESMTP
	id S264833AbUFQPSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:18:33 -0400
Date: Fri, 18 Jun 2004 01:17:31 +1000 (EST)
From: Finn Thain <ft01@webmastery.com.au>
To: Andreas Schwab <schwab@suse.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: make checkstack on m68k
In-Reply-To: <je3c4uqum0.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0406180048180.13963@bonkers.disegno.com.au>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
 <je3c4uqum0.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Andreas Schwab wrote:

> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
> > I tried to add m68k support to `make checkstack', but got stuck due to my
> > limited knowledge of complex perl expressions. I actually need to catch both
> > expressions (incl. the one I commented out). Anyone who can help?
>
> Untested:
>
>   $re = qr/.*(?:linkw %fp,|addw )#-([0-9]{1,4})(?:,%sp)?$/o;
>
> Andreas.

I think that should be addaw, not addw. And it may be necessary to remove
the $ anchor at the end.

Your solution makes very nice use of the fact that objdump produces
exactly one comma for those opcodes :)

-F
