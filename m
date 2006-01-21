Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWAUB6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWAUB6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWAUB6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:58:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932389AbWAUB6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:58:21 -0500
Date: Fri, 20 Jan 2006 18:00:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, ak@muc.de, matthew.e.tolentino@intel.com
Subject: Re: __cpuinit functions wrongly marked __meminit
Message-Id: <20060120180015.061686fd.akpm@osdl.org>
In-Reply-To: <20060120173723.A7060@unix-os.sc.intel.com>
References: <20060120173723.A7060@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> __meminit has overzelously been modified and crept its way
> into marking cpuup callbacks as __meminit. 

OK.

We do have tools which will auto-detect things like this. 
reference_discarded.pl, reference_init.pl.  I think they should work in
this case.  One would need to use a number of .config combinations to get
full coverage of course.  
