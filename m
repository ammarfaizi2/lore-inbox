Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269749AbUJGH1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269749AbUJGH1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 03:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269748AbUJGH1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 03:27:47 -0400
Received: from fmr03.intel.com ([143.183.121.5]:56510 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S269745AbUJGH0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 03:26:52 -0400
Date: Thu, 7 Oct 2004 00:25:50 -0700
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: common code between i386 and x86_64 (was Re: [Patch] share i386/x86_64 intel cache descriptors table)
Message-ID: <20041007002550.A12738@unix-os.sc.intel.com>
References: <20041006184723.A10900@unix-os.sc.intel.com> <4164B71A.30105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4164B71A.30105@pobox.com>; from jgarzik@pobox.com on Wed, Oct 06, 2004 at 11:25:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 11:25:14PM -0400, Jeff Garzik wrote:
> 
> I have often wondered if there is any value to creating arch/x86 and 
> include/asm-x86 for stuff shared between x86-64 and i386.

Yes. There is definitely some value. Currently this kind of code is scattered
all around the place. With this demarcation, people touching this common
code will be careful of not breaking arch's that are sharing this code.

We can avoid duplicate data structure definitions and duplicate prototypes.

thanks,
suresh
