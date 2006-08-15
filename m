Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWHOGEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWHOGEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWHOGEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:04:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:59276 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965170AbWHOGEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:04:20 -0400
Date: Tue, 15 Aug 2006 08:04:19 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/3] Support piping into commands in /proc/sys/kernel/core_pattern
Message-ID: <20060815060419.GB15159@wotan.suse.de>
References: <20060814127.183332000@suse.de> <20060814112732.684D313BD9@wotan.suse.de> <20060814174319.94294a54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814174319.94294a54.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 05:43:19PM -0700, Andrew Morton wrote:
> On Mon, 14 Aug 2006 13:27:32 +0200 (CEST)
> Andi Kleen <ak@suse.de> wrote:
> 
> > The core dump proces will run with the privileges and in the name space
> > of the process that caused the core dump.
> 
> Don't think so.   __call_usermodehelper() is executed by the khelper kernel thread.

Yes, you're right the comment is wrong. It does run as root instead
with global name space. I needed that because otherwise
it needed a global writable directory for the core dumps. 

Feel free to change it in your version.

That happens when you write the description months later than the code ...

-Andi
