Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVAELie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVAELie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVAELie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:38:34 -0500
Received: from [213.146.154.40] ([213.146.154.40]:5777 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262346AbVAELhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:37:04 -0500
Date: Wed, 5 Jan 2005 11:37:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Gildas LE NADAN <gildas.le-nadan@inha.fr>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: unkillable processes using samba, xfs and lvm2 snapshots (k 2.6.10)
Message-ID: <20050105113701.GA31391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gildas LE NADAN <gildas.le-nadan@inha.fr>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <41D14251.4030704@inha.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D14251.4030704@inha.fr>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 12:24:01PM +0100, Gildas LE NADAN wrote:
> Hi,
> 
> I experience hangs on samba processes on a filer using xfs over lvm2 as 
> data partitions, when there is active snapshots of the xfs partitions.
> 
> I have a clone of the production server (same software, same hardware) 
> where the situation can be reproduced perfectly.
> 
> Testings showed that the result was the same, whether the snapshots were 
> mounted or not : smbd processes are locked and unkillable while the 
> machine is normaly working otherwise, except software reboot is 
> impossible and hardware reset is needed.
> 
> I noticed Brad Fitzpatrick's case in kernel 2.6.10 changelog 
> (http://lkml.org/lkml/2004/11/14/98) and tested kernel 2.6.10 today 
> without success.
> 
> Configuration is the following :
> - supermicro m/b with dual Xeon 2,8Ghz (SMT is active)
> - 1 GB ram,
> - adaptec u320 raid controler
> - kernel 2.6.10
> - debian sarge
> - samba 3
> - LVM2
> - XFS with quota turned on
> 
> All software are from debian sarge packages, except the kernel.
> 
> I'm not able to determine if the problem is more xfs, device mapper or 
> samba related, and was not able to do extensive testings (using a 
> different filesystem, testing with a different daemon, etc...), but 
> SMT/SMP testings showed that this is not a SMP/SMT related problem.
> 
> I've compiled the kernel with the debugging options, so I might provide 
> additional informations if needed as in Brad's case.

I'll try to reproduce your problems soon.

