Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWFWO7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWFWO7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWFWO7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:59:10 -0400
Received: from shell.pcisys.net ([216.229.32.243]:1720 "EHLO shell.pcisys.net")
	by vger.kernel.org with ESMTP id S1750820AbWFWO7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:59:09 -0400
Date: Fri, 23 Jun 2006 08:59:03 -0600
From: Brian Hall <brihall@pcisys.net>
To: Sebastian Noack <xaon.seb@gmx.net>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] problem burning DVDs with 2.6.17-ck1 (mlockall?)
Message-ID: <20060623145903.GA12719@pcisys.net>
References: <200606230819.44551.xaon.seb@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606230819.44551.xaon.seb@gmx.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 08:19:44AM +0200, Sebastian Noack wrote:
> Hi!
> 
> Look here :
> 
>  /usr/portage/app-cdr/dvd+rw-tools/dvd+rw-tools-6.1-r1.ebuild
> 
> pkg_postinst() {
> einfo
> einfo "When you run growisofs if you receive:"
> einfo "unable to anonymously mmap 33554432: Resource temporarily unavailable"
> einfo "error message please run 'ulimit -l unlimited'"

Aha! Solved, thanks.

echo "ulimit -l unlimited" >> /etc/conf.d/local.start

Thanks to all for the quick replies.



