Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbULCELi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbULCELi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 23:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbULCELi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 23:11:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45736 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261954AbULCEHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 23:07:52 -0500
Message-ID: <41AFE68B.7010906@pobox.com>
Date: Thu, 02 Dec 2004 23:07:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dma errors with sata_sil and Seagate disk
References: <20041201115045.3ab20e03@homer.sarvega.com>	<1101944482.30990.74.camel@localhost.localdomain>	<yw1xpt1tuihe.fsf@ford.inprovide.com>	<1102030431.7175.9.camel@localhost.localdomain> <yw1xvfbkrxn0.fsf@ford.inprovide.com>
In-Reply-To: <yw1xvfbkrxn0.fsf@ford.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Does this mean it is the drives which are faulty, not the controller?
> These drives are both new, so I suppose known problems might have been
> fixed.  FWIW, they are reported by the kernel thusly:


The issue is that the SiI 311x controllers send out packets (called 
"FIS's" in SATA-land) that are not multiples of 512 bytes.

This is perfectly legal according to SATA spec, but early drive 
firmwares (notoriously Seagate in this case) were written with the 
assumption that the FIS's would be multiples of 512 bytes.

	Jeff


