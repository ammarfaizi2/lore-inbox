Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUGTSzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUGTSzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUGTSwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:52:10 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:63928 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266183AbUGTSsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:48:30 -0400
Date: Tue, 20 Jul 2004 20:48:24 +0200
From: bert hubert <ahu@ds9a.nl>
To: Shesha Sreenivasamurthy <shesha@inostor.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>
Subject: Re: O_DIRECT
Message-ID: <20040720184824.GA30090@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Shesha Sreenivasamurthy <shesha@inostor.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>
References: <40FD561D.1010404@inostor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FD561D.1010404@inostor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 10:27:57AM -0700, Shesha Sreenivasamurthy wrote:
> I am having trouble with O_DIRECT. Trying to read or write from a block 
> device partition.
> 
> 1. Can O_DIRECT be used on a plain block device partition say 
> "/dev/sda11" without having a filesystem on it.

As fas as I know, yes, but be aware that O_DIRECT requires page aligned
addresses! (an integral of 4096 on most systems).

> 2. If no file system is created then what should be the softblock size. 
> I am using the IOCTL "BLKBSZGET". Is this correct?

No idea what you mean - but see above about the aligned addresses.

> 3. Can we use SEEK_END with O_DIRECT on a partition without filesystem.

I see no reason why not. Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
