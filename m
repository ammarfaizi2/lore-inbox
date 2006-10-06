Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWJFMJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWJFMJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 08:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWJFMJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 08:09:20 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:31767 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750839AbWJFMJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 08:09:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAAjjJUWMEA0
X-IronPort-AV: i="4.09,272,1157320800"; 
   d="scan'208"; a="3920859:sNHT30996280"
Date: Fri, 6 Oct 2006 14:09:17 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 01/02] net/ipv6: seperate sit driver to extra module
Message-ID: <20061006120917.GC12460@zlug.org>
References: <20061006093402.GA12460@zlug.org> <87d595lln3.fsf@willow.rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d595lln3.fsf@willow.rfc1149.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 01:38:24PM +0200, Samuel Tardieu wrote:
> >>>>> "Joerg" == Joerg Roedel <joro-lkml@zlug.org> writes:
> 
> Joerg> this is the submit of the patch discussed yesterday to compile
> Joerg> the sit driver as a seperate module.
> 
> Your patch looks ok to me, but given that many people won't need sit,
> why is it enabled by default? Omitting it would save 10k of kernel
> text on x86 and people will see the new kernel configuration option
> anyway and will enable it if needed.

It is enabled per default because the users get this per default when
using the current IPv6 module. James Morris mentioned this issue
yesterday. I think setting the default to N would be more consistent,
but the Y is probably less painfull for the users.

Joerg
