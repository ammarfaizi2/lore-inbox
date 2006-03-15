Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWCOU6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWCOU6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 15:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWCOU6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 15:58:44 -0500
Received: from kanga.kvack.org ([66.96.29.28]:29904 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750741AbWCOU6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 15:58:44 -0500
Date: Wed, 15 Mar 2006 15:53:06 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Message-ID: <20060315205306.GC25361@kvack.org>
References: <20060315193114.GA7465@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315193114.GA7465@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 02:31:14PM -0500, Vivek Goyal wrote:
> Is there a reason why "start" and "end" field of "struct resource" are of
> type unsigned long. My understanding is that "struct resource" can be used
> to represent any system resource including physical memory. But unsigned
> long is not suffcient to represent memory more than 4GB on PAE systems. 
> and compiler starts throwing warnings. 

Please make this depend on the kernel being compiled with PAE.  We don't 
need to bloat 32 bit kernels needlessly.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
