Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUGKU1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUGKU1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 16:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUGKU1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 16:27:18 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:47793 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S266658AbUGKU1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 16:27:01 -0400
Date: Sun, 11 Jul 2004 22:26:55 +0200
From: Antonin Kral <A.Kral@sh.cvut.cz>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fatal problem, possibly related to AIC79xx
Message-ID: <20040711202655.GI8132@sh.cvut.cz>
References: <20040710152125.GD21718@sh.cvut.cz> <20040711200707.GB1545@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711200707.GB1545@alpha.home.local>
X-URL: http://www.bobek.cz
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've run memtest for more than 48 hours. And actually I have two boxes
with same behaviour. I was thinking about more precise check of SCSI bus
termination...

Regards,
    Antonin

* Willy Tarreau <willy@w.ods.org> [2004-07-11 22:23] wrote:
> Looks like a hardware problem to me. Perhaps higher transfer rates obtained
> with aic7xxx triggers it faster. You should really run cpuburn (burnBX) and
> memtest86 on this box.
> 
> Regards,
> Willy
> 
> On Sat, Jul 10, 2004 at 05:21:25PM +0200, Antonin Kral wrote:
> > Hi all,
> > 
> > I'm trying to install Linux (in particular Debian) to our new servers.
> > These servers are based od motherbard SuperMicro X5DL8-GG with aic7902
> > without RAID, 1GB RAM, one XEON 3.06GHz
> > 
> > I have two, really strange problems, first of all I have noticed, that
> > with enabled SMP support kernel detects TWO processors, but only one is
> > physically installed.
> > 
> > The second problem is, that I am not able to run almost any program.
> > E.g. if I try to execute free I'll get "Illegal instruction", for mount
> > I'll get "Segmentation Fault".
> > 
> > What I've tried:
> > 
> >   Vanilla kernels 2.4.25, 2.4.26, 2.6.6, 2.6.7. And almost all
> > combinations with/without:
> >           * SMP
> >           * APIC
> >           * Highmem
> >           * MTRR
> > 
> > All without ACPI and with aic79xx and e1000 build in kernel.
> > 
> >   I've tried Knoppix 3.4. The strange think was that I was unable to
> > load module for aic79xx, because of "no such device".
> > 
> > Does anyone have any idea how to solve my problems?
> > 
> >   Thank you, best regards,
> > 
> >         Antonin Kral
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
