Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTIIV0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTIIV0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:26:46 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:51847 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264565AbTIIV0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:26:31 -0400
Subject: Re: 2.4.21 -> 2.4.22 kernel thread oddities
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hendriks@lanl.gov
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030909192913.GE10623@lanl.gov>
References: <20030909192913.GE10623@lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063142708.30962.24.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 22:25:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-09 at 20:29, hendriks@lanl.gov wrote:
> The "unshare_files" addition to execve() is having some unexpected
> side effects for a funky init() program that I use on our clusters.
> Basically the problem is that standard-equipment type kernel threads
> (e.g. kupdated, bdflush) are ending up with open file descriptors on a
> file system that I wish to unmount.

I sent Marcelo a fix for this in 2.4.23pre/2.4.22-ac - see the change to
init/main.c


