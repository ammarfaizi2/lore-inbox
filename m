Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbSKTNR7>; Wed, 20 Nov 2002 08:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266094AbSKTNR7>; Wed, 20 Nov 2002 08:17:59 -0500
Received: from elin.scali.no ([62.70.89.10]:51716 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S266091AbSKTNR6>;
	Wed, 20 Nov 2002 08:17:58 -0500
Date: Wed, 20 Nov 2002 14:27:20 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Arjan van de Ven <arjanv@redhat.com>
cc: Hugh Dickins <hugh@veritas.com>, Jun Nakajima <jun.nakajima@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] Xeon with HyperThreading and linux-2.4.20-rc2
In-Reply-To: <20021120080422.A1498@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0211201417000.13800-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Arjan van de Ven wrote:

> On Wed, Nov 20, 2002 at 12:53:04PM +0000, Hugh Dickins wrote:
> > 
> > I know too little to comment definitively, but it's my understanding
> > that a dual HT machine should only show 2 processors in its MP table,
> > their siblings only appearing through analysis of the ACPI tables.
> > 
> > Whether it's that your MP table has been wrongly set up, or that
> > you've really been given 4 processors when you only asked for 2
> > (sue your supplier!), I cannot say.  I've copied Jun at Intel
> > and Arjan at RedHat, and hope they can shed more light on this.
> 
> Linux has zero problem with a sane MP table that lists all
> CPU's. Intel normally seems to recommend against it (maybe N3.51 doesn't
> like it or so) but it's all fair as far as I'm concerned.
> The bios is supposed to offer you a choice
> to disable hyperthreading, use that ;)
> 

Sure, the bios has this option (and it works). I just believed the 'noht' 
option would disable it from a kernel perspective. I understand that if 
the MP table lists 4 processors, the kernel must think it is 4 processors 
and enable them. But what is the purpose of the 'noht' option ? If it is 
to avoid scanning the ACPI table for CPUs, wouldn't it be less confusing 
to call it something like 'acpismp=disable', since you apparently can't 
disable the siblings anyway (when they are also listed in the MP table) ?

Regards,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

