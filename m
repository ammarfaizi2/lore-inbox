Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVAOCKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVAOCKh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAOCKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:10:37 -0500
Received: from [81.2.110.250] ([81.2.110.250]:234 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262114AbVAOCKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:10:33 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050115014440.GA1308@muc.de>
References: <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
	 <1105626399.4664.7.camel@localhost.localdomain>
	 <20050113180347.GB17600@muc.de>
	 <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>
	 <1105645491.4624.114.camel@localhost.localdomain>
	 <20050113215044.GA1504@muc.de>
	 <1105743914.9222.31.camel@localhost.localdomain>
	 <20050115014440.GA1308@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105750898.9222.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 01:01:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-15 at 01:44, Andi Kleen wrote:
> Then it won't work with this BIST hardware anyways - if it tries
> to read config space of a device that is currently in BIST 
> it will just get a bus abort and no useful information.

So it should wait to preseve a sane API at least for a short while and
if the user hasn't specified O_NDELAY. Its a compatibility consideration

> The only point of this whole patch exercise is to avoid the bus abort
> to satisfy the more strict hardware error checking on PPC64. On PCs
> it really won't make any difference.

I thought Ben wanted to do this for other PPC stuff ?

