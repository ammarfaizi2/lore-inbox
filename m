Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287919AbSAVB1Q>; Mon, 21 Jan 2002 20:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289135AbSAVB1E>; Mon, 21 Jan 2002 20:27:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23656 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287919AbSAVB0x>; Mon, 21 Jan 2002 20:26:53 -0500
Date: Tue, 22 Jan 2002 02:27:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: reid.hekman@ndsu.nodak.edu, linux-kernel@vger.kernel.org, akpm@zip.com.au,
        alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
Message-ID: <20020122022751.P8292@athlon.random>
In-Reply-To: <20020121175410.G8292@athlon.random> <20020121.141931.105134927.davem@redhat.com> <20020122013743.M8292@athlon.random> <20020121.170745.52090023.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020121.170745.52090023.davem@redhat.com>; from davem@redhat.com on Mon, Jan 21, 2002 at 05:07:45PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 05:07:45PM -0800, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Tue, 22 Jan 2002 01:37:43 +0100
> 
>    On Mon, Jan 21, 2002 at 02:19:31PM -0800, David S. Miller wrote:
>    > That's not true, see the ptrace() helper code.  Russell King pointed
>    > this out to me last week and it's on my TODO list to fix it up.
>    
>    Where? :) ptrace doesn't change pagetables, no need to flush any tlb in
>    ptrace.
>    
> egrep flush_*_page kernel/ptrace.c:access_process_vm()

that is not a tlb flush, it's a noop on x86 infact.

andrea@athlon:~/devel/kernel/2.4.18pre4aa1> egrep tlb kernel/ptrace.c
andrea@athlon:~/devel/kernel/2.4.18pre4aa1> 

Andrea
