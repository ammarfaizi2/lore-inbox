Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTKNIea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 03:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTKNIea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 03:34:30 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:40722 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261889AbTKNIe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 03:34:28 -0500
Date: Fri, 14 Nov 2003 09:36:46 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Davide Libenzi <davidel@xmailserver.org>
cc: Roland Lezuo <roland.lezuo@chello.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-rc1: SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
In-Reply-To: <Pine.LNX.4.44.0311130833480.1809-100000@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.44.0311140928350.19678-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Davide Libenzi wrote:

> > SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
> > SiS router unknown request: (97)
> > SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
> > SiS router unknown request: (97)
> > 
> > I though the patch has already been merged?
> 
> The latest CVS snapshot I was able to rsync from kernel.org had the fix 
> and should make it work:
> 
> [root@drizzle src]# head linux-2.4/Makefile
> VERSION = 2
> PATCHLEVEL = 4
> SUBLEVEL = 23
> EXTRAVERSION = -pre9
> 
> Request 97 is one of the new ones (USB) correctly handled by the patch.

I don't think this will help in his case. I believe the 745 comes with a 
more recent flavour of the 5595, not 96x. It looks like they have changed 
the pirq routing registers before 96x appeared. So I think it's not enough 
to decide which scheme to use depending on the device id. Btw, I still 
like my suggestion to use the pci revision id of the router function 
(1039:0008) which we had discussed at that time. ;-)

Roland, could you send the output from "lspci -vxxx -d:8" please for 
verification?

Martin

