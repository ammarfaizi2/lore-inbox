Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWAOXxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWAOXxP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 18:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWAOXxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 18:53:15 -0500
Received: from xenotime.net ([66.160.160.81]:43908 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751000AbWAOXxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 18:53:14 -0500
Date: Sun, 15 Jan 2006 15:53:05 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Reinhold Jordan <r.jordan@asc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: option memmap
Message-Id: <20060115155305.339b9310.rdunlap@xenotime.net>
In-Reply-To: <43C51ABD.4050204@asc.de>
References: <43C51ABD.4050204@asc.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 15:48:29 +0100 Reinhold Jordan wrote:

> Hello,
> 
> is there any documentation for this option better than this in
> linux/Documentation/kernel-parameters.txt ?
> 
> I have a laptop with a defect memory soldered on the main-board.
> 128KB of 128MB are defect started at 7936KB
> 
> As I read from kernel-parameters.txt the option
> memmap=128K$7936K
> reserve this area. But this seems to be simply ignored. Even, if I
> fade out 64MB, Knoppix still create a RAM disk, which is larger
> as the remaining memory...
> 
> Does someone know advice?

Please give the complete list of kernel boot options that
you used.

Documentation/kernel-parameters.txt does say (for IA-32)
to use mem= and memmap= together in some cases.

And there are some comments in the source code
(arch/i386/kernel/setup.c) but they probably don't help
any more than the Doc file does:

  * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
  * to <mem>, overriding the bios size.
  * "memmap=XXX[KkmM]@XXX[KkmM]" defines a memory region from
  * <start> to <start>+<mem>, overriding the bios size.


---
~Randy
