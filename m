Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWCOVeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWCOVeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWCOVeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:34:18 -0500
Received: from kanga.kvack.org ([66.96.29.28]:50640 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751467AbWCOVeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:34:16 -0500
Date: Wed, 15 Mar 2006 16:28:41 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kumar Gala <galak@kernel.crashing.org>, Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Message-ID: <20060315212841.GE25361@kvack.org>
References: <20060315193114.GA7465@in.ibm.com> <20060315205306.GC25361@kvack.org> <46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org> <20060315211335.GD25361@kvack.org> <m1y7zbe6rn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y7zbe6rn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 02:29:32PM -0700, Eric W. Biederman wrote:
> If the impact is very slight or unmeasurable this means the option
> needs to fall under CONFIG_EMBEDDED, where you can change if
> every last bit of RAM counts but otherwise you won't care.

But we have a data type that is correct for this usage: dma_addr_t.

> Having > 32bit values on a 32bit platform is not the issue.
> 
> Some drivers appear to puke simply because the value is 64bit.  Which
> means the driver will have problems on any 64bit kernel.  That kind
> of behavior is worth purging.

Forcing it to be a 64 bit value doesn't fix that problem, so that isn't 
a valid excuse for adding bloat.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
