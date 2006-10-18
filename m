Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWJRNI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWJRNI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWJRNI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:08:59 -0400
Received: from ns.suse.de ([195.135.220.2]:62666 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030273AbWJRNI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:08:58 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Undeprecate the sysctl system call
Date: Wed, 18 Oct 2006 15:08:54 +0200
User-Agent: KMail/1.9.3
Cc: Cal Peake <cp@absolutedigital.net>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <453519EE.76E4.0078.0@novell.com> <200610181441.51748.ak@suse.de> <1161176382.9363.35.camel@localhost.localdomain>
In-Reply-To: <1161176382.9363.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181508.54237.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 14:59, Alan Cox wrote:
> Ar Mer, 2006-10-18 am 14:41 +0200, ysgrifennodd Andi Kleen:
> > It's less work long term, mostly because all the rejects for sysctl.h will 
> > go away. And it's more compatible than just removing sysctl(2) completely.
> 
> What rejects for sysctl.h, nobody is going to add new entries to
> sysctl(2) so there will be no rejects.

Yes, but it still means the bizarre register_sysctl() call convention
has to be maintained internally.

If the existing sysctl.c/sysctl.h stuff wasn't needed anymore this
could be replaced with a sane

register_sysctl_name("a/b/c", &sysctl_struct) 

and clean up a lot of code.

-Andi
