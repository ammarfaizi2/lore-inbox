Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWJIXPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWJIXPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 19:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWJIXPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 19:15:21 -0400
Received: from main.gmane.org ([80.91.229.2]:53717 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751921AbWJIXPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 19:15:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: sky2 (was Re: 2.6.18-mm2)
Date: Mon, 9 Oct 2006 23:14:27 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrneilm0q.3mc.olecom@deen.upol.cz.local>
References: <20060928155053.7d8567ae.akpm@osdl.org> <451C5599.80402@garzik.org> <20060928161956.5262e5d3@freekitty> <1159930628.16765.9.camel@mhcln03> <20061003202643.0e0ceab2@localhost.localdomain> <1160250529.4575.7.camel@mhcln03> <1160314905.4575.21.camel@mhcln03> <20061008092001.0c83a359@localhost.localdomain> <1160326801.4575.27.camel@mhcln03> <1160332296.4575.31.camel@mhcln03> <20061009094504.7b58eb2d@freekitty>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.180.30
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-09, Stephen Hemminger <shemminger@osdl.org> wrote:
> On Sun, 08 Oct 2006 20:31:36 +0200
> Matthias Hentges <oe@hentges.net> wrote:
>
>> 
>> Oops, I forgot the "x" in lspci -vvvx, new dumps are attached.
>
>
> I think I know what the problem is. The PCI access routines to access pci express
> registers (ie reg > 256), only work if using MMCONFIG access. For some reason
> your configuration doesn't want to use/allow that.

In case you didn't read, here's top of thread about MMCONFIG 4 days ago:
<http://article.gmane.org/gmane.linux.ports.x86-64.general/1794>

In short: due to Intel BIOS bug, mmconfig doesn't used in kernel.
And kernel developers mainly do not care much (yet) about drivers, until
vi$ta certified hardware will be in run.
____

