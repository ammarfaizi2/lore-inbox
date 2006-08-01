Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWHAS4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWHAS4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWHAS4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:56:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:37059 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750938AbWHAS43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:56:29 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Enable binding to local IPv4 IP address for CIFS file system.
References: <44CF8FCF.6070401@candelatech.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 20:56:26 +0200
In-Reply-To: <44CF8FCF.6070401@candelatech.com>
Message-ID: <p734pww2skl.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:
> 
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 006eb33..1f34c3f 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -118,6 +118,7 @@ struct TCP_Server_Info {
>   		struct sockaddr_in sockAddr;
>   		struct sockaddr_in6 sockAddr6;
>   	} addr;
> +	u32 ip4_local_ip; /* if != 0, will bind locally to this IP */

adding a ipv4 only, no ipv6 feature like this at this age seems quite
backwards. If anything you should think of easy expansion to IPv6 at least.

-Andi
