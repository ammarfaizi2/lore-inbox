Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272821AbTG3Jns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 05:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272822AbTG3Jns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 05:43:48 -0400
Received: from ppp3290-cwdsl.fr.cw.net ([62.210.105.37]:20864 "EHLO
	bouton.inet6-interne.fr") by vger.kernel.org with ESMTP
	id S272821AbTG3Jnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 05:43:46 -0400
Date: Wed, 30 Jul 2003 11:43:38 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA timeouts on SIS IDE
Message-ID: <20030730114338.A1556@bouton.inet6-interne.fr>
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <yw1xr849pbj6.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <yw1xr849pbj6.fsf@users.sourceforge.net>; from mru@users.sourceforge.net on mar, jui 29, 2003 at 06:01:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mar, jui 29, 2003 at 06:01:33 +0200, Måns Rullgård wrote:
> 
> I'm running Linux 2.6.0-test2 with Ingo's G7 and the SOFT_RR patches
> on an Asus laptop with a SIS IDE controller.  When writing large
> amounts of data to the disk, I get these messages in the kernel log
> after a while:
> 
> hda: dma_timer_expiry: dma status == 0x21
> hda: DMA timeout error
> hda: dma timeout error: status=0xd0 { Busy }
> 
> hda: DMA disabled
> ide0: reset: success

Could you post the output of "lspci -vxxx -s2.5", "dmesg" and finally
"hdparm -i" for each drive please ?

> 
> The messages repeat at irregular intervals.  Sometimes DMA is
> disabled.  It never happens during normal use, only when writing files
> larger than a few hundred megabytes.  While writing, the machine is
> all but interactive.  Actually, interactivity comes and goes.  In
> periods it's decent, while in between the machine looks almost dead,
> e.g. the mouse pointer in X doesn't move.  I'm comparing this to an
> Alpha machine with a Highpoint HPT374.  There I barely notice that
> anything is going on with the disk.
> 
> Any clues as to what's going on?  The data appears to be intact,
> thankfully.
> 

Recently there were changes to the code setting IDE timings for this
chipset. This is an unlikely culprit but the lspci output will help to
clear any remaining doubts.

Best regards,

LB
