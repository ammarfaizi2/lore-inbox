Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUB0Wpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUB0Wp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:45:26 -0500
Received: from codepoet.org ([166.70.99.138]:31902 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263186AbUB0Woc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:44:32 -0500
Date: Fri, 27 Feb 2004 15:44:31 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
Message-ID: <20040227224431.GB984@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	John Bradford <john@grabjohn.com>, Erik van Engelen <Info@vanE.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <403F2178.70806@vanE.nl> <Pine.LNX.4.58L.0402271629430.19209@logos.cnet> <1077908499.29713.19.camel@dhcp23.swansea.linux.org.uk> <200402272114.23108.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402272114.23108.bzolnier@elka.pw.edu.pl>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 27, 2004 at 09:14:23PM +0100, Bartlomiej Zolnierkiewicz wrote:
> ide-disk.c sends WIN_READ_NATIVE_MAX_{EXT} without checking
> if HPA feature set is supported, this is fixed in 2.6.x for a long time.
> 
> We need 2.4<->2.6 IDE sync monkey... a really smart one...

Dunno if I qualify as sufficiently 'really smart' enough but the
last time I put in the considerable effort needed to re-sync the
2.4 and 2.6 IDE layers, and merge in the useful -ac bits that
never made it into mainstream, nothing whatsoever came of my
efforts...

My 2.4.x patches are in daily use by a large group of people
and they work fine, for what it is worth.  My IDE merging
patches are the following:

    http://codepoet.org/kernel/

    020_ide_layer_2.4.22-ac4.bz2
    021_ide_geom_hpa_capacity64.bz2
    022-extra-ide-drives.bz2
    023-2.4.25-libata1.patch.bz2
    024_libata-spurious2.diff.bz2
    025-cenatek.patch.bz2
    026-medley-softraid.patch.bz2

The 021_ide_geom_hpa_capacity64.bz2 is my original work, the
others are the result of skimming patches from the list and
merging/updating them as needed to sync with the other patches
and keep them current.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
