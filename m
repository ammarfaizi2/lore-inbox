Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTDYN4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbTDYN4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:56:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48264
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263176AbTDYN4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:56:31 -0400
Subject: RE: cciss patches for 2.4.21-rc1, 4 of 4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Cameron, Steve" <Steve.Cameron@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF1040528C8@cceexc23.americas.cpqcorp.net>
References: <D4CFB69C345C394284E4B78B876C1CF1040528C8@cceexc23.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051276193.5902.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Apr 2003 14:09:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-25 at 14:48, Miller, Mike (OS Dev) wrote:
> I haven't seen any issues (yet) on ia64. I'm running with 5GB RAM.

That doesn't make it correct. This same problem occurs in other drivers
and the usual trick is to set the pci mask to 32bit, allocate those
command buffers ready, then flip back to 64bit. Just be sure one thread
doesn't change it to 64bit while another is allocating commands. The
reverse is fine since an accidental odd bounce is no big deal

