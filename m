Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSKNVwJ>; Thu, 14 Nov 2002 16:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSKNVwJ>; Thu, 14 Nov 2002 16:52:09 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:8179 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S265285AbSKNVwJ>; Thu, 14 Nov 2002 16:52:09 -0500
Date: Thu, 14 Nov 2002 16:59:03 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Rohit Seth <rseth@unix-os.sc.intel.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114165903.F20258@redhat.com>
References: <20021113184555.B10889@redhat.com> <20021114203035.GF22031@holomorphy.com> <20021114154809.D20258@redhat.com> <20021114210220.GM23425@holomorphy.com> <20021114161134.E20258@redhat.com> <3DD41849.20306@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DD41849.20306@unix-os.sc.intel.com>; from rseth@unix-os.sc.intel.com on Thu, Nov 14, 2002 at 01:40:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 01:40:25PM -0800, Rohit Seth wrote:
> Strictly speaking user don't have to be root.  Currently the syscall 
> only requires users to have root as one of the supplementary groups (and 
> that is how Oracle is actually using these syscalls).  And if 
> CAP_IPC_LOCK (to make it coherent with fs side of the world) is what is 
> preferdto provide access to hugepages then that change is simple also. 
>  Don't need to do any chmod.

Chmod is easier to administor (the special permissions are obvious with 
a standard tool called ls), and doesn't require giving random apps root 
privs (good practice still dictates that database backends should not 
have root).  Capabilities would work, but have yet to catch on in any 
real sense and are lacking in terms of useful tools in most distributions.

		-ben
-- 
"Do you seek knowledge in time travel?"
