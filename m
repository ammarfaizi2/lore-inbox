Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318572AbSHBGbp>; Fri, 2 Aug 2002 02:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318623AbSHBGbp>; Fri, 2 Aug 2002 02:31:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27358 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318572AbSHBGbo>;
	Fri, 2 Aug 2002 02:31:44 -0400
Date: Thu, 01 Aug 2002 23:33:26 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>
cc: gh@us.ibm.com, riel@conectiva.com.br, akpm@zip.com.au,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohit.seth@intel.com,
       sunil.saxena@intel.com, asit.k.mallick@intel.com
Subject: Re: large page patch 
Message-ID: <868823061.1028244804@[10.10.2.3]>
In-Reply-To: <15690.9727.831144.67179@napali.hpl.hp.com>
References: <15690.9727.831144.67179@napali.hpl.hp.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   DaveM>    In my opinion the proposed large-page patch addresses a
>   DaveM> relatively pressing need for databases (primarily).
> 
>   DaveM> Databases want large pages with IPC_SHM, how can this
>   DaveM> special syscal hack address that?
> 
> I believe the interface is OK in that regard.  AFAIK, Oracle is happy
> with it.

Is Oracle now the world's only database? I think not.
 
>   DaveM> It's great for experimentation, but give up syscall slots
>   DaveM> for this?
> 
> I'm a bit concerned about this, too.  My preference would have been to
> use the regular mmap() and shmat() syscalls with some
> augmentation/hint as to what the preferred page size is 

I think that's what most users would prefer, and I don't think it
adds a vast amount of kernel complexity. Linus doesn't seem to
be dead set against the shmem modifications at least ... so that's
half way there ;-)

M.
