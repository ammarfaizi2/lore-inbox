Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWATMoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWATMoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWATMoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:44:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750920AbWATMoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:44:25 -0500
Date: Fri, 20 Jan 2006 04:44:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tony Mantler <nicoya@ubb.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_MK6 = lsof hangs unkillable
Message-Id: <20060120044407.432eae02.akpm@osdl.org>
In-Reply-To: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca>
References: <6951EFDF-9499-40D5-AD09-2AE217A0A579@ubb.ca>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Mantler <nicoya@ubb.ca> wrote:
>
> I'm having trouble running lsof on 2.6.15.1 when the kernel is  
> compiled with CONFIG_MK6. When run as root, lsof will segfault, and  
> when run as a user lsof will hang unkillable.
> 
> The same kernel, same machine, but compiled with CONFIG_MK7 runs just  
> lsof just fine.

That's creepy.  CONFIG_MK6 hardly does anything.  The main thing it does is
feed `-march=k6' into the compiler.  MK7 uses `-march=athlon'.

Are you able to try a different gcc version?

