Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWCOVTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWCOVTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWCOVTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:19:03 -0500
Received: from kanga.kvack.org ([66.96.29.28]:37584 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751396AbWCOVTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:19:00 -0500
Date: Wed, 15 Mar 2006 16:13:35 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Message-ID: <20060315211335.GD25361@kvack.org>
References: <20060315193114.GA7465@in.ibm.com> <20060315205306.GC25361@kvack.org> <46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 03:05:30PM -0600, Kumar Gala wrote:
> I disagree.  I think we need to look to see what the "bloat" is  
> before we go and make start/end config dependent.

Eh?  32 bit kernels get used in embedded systems, which includes those 
with only 8MB of RAM.  The upper 32 bits will never be anything other 
than 0.

> It seems clear that drivers dont handle the fact that "start"/"end"  
> change an 32-bit vs 64-bit archs to begin with.  By making this even  
> more config dependent seems to be asking for more trouble.

You can't get a non-32 bit value on a 32 bit platform, so why should a 
driver be expected to handle anything?

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
