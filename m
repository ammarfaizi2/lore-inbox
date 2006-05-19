Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWESXa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWESXa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 19:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWESXa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 19:30:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46296 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964784AbWESXa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 19:30:57 -0400
Date: Fri, 19 May 2006 16:30:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: mel@csn.ul.ie (Mel Gorman)
Cc: evil@g-house.de, linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: SCSI ABORT with 2.6.17-rc4-mm1
Message-Id: <20060519163038.7236c8e3.akpm@osdl.org>
In-Reply-To: <20060519225746.GA11883@skynet.ie>
References: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
	<20060519141032.23de6eee.akpm@osdl.org>
	<20060519225746.GA11883@skynet.ie>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mel@csn.ul.ie (Mel Gorman) wrote:
>
> I am struggling to see how the alignment patches or
>  arch-independent-zone-sizing would clobber the mapping of the ACPI table :(

hm.  Well something did it ;)

>  > I also managed to provoke "Too many memory regions,
>  > truncating" out of it.
>  >
> 
>  "Too many memory regions, truncating" is of concern because memory will be 
>  effectively lost. Is this on x86_64 as well? If so, I need to submit a 
>  patch that sets CONFIG_MAX_ACTIVE_REGIONS to 128 on x86_64 which is the 
>  same value of E820MAX. This is similar to what PPC64 does for LMB regions 
>  (see MAX_ACTIVE_REGIONS in arch/powerpc/Kconfig for example). If it's not 
>  x86_64, what arch does it occur on?

Yes, it's x86_64.  It kind of went away though.  I seem to have been
finding various .config combinations which cause x86_64 to die horridly -
that was one.
