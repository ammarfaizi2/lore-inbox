Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTBKQCa>; Tue, 11 Feb 2003 11:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTBKQCa>; Tue, 11 Feb 2003 11:02:30 -0500
Received: from franka.aracnet.com ([216.99.193.44]:21407 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262425AbTBKQC3>; Tue, 11 Feb 2003 11:02:29 -0500
Date: Tue, 11 Feb 2003 08:11:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hartmut Manz <manz@intes.de>, linux-kernel@vger.kernel.org
Subject: Re: allocate more than 2 GB on IA32
Message-ID: <86310000.1044979897@[10.10.2.4]>
In-Reply-To: <200302111015.54223.manz@intes.de>
References: <200302111015.54223.manz@intes.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i would like to allocate more than 2 GB of memory on an IA32 architecture.
> 
> The machine is a dual XEON_DP with 3 GB of Ram and 4 GB of swap space.
> 
> I have tried with the default SUSE 8.1 kernel as well as with a
> 2.4.20-pre4aa1 Kernel compile by my own using these Options:
> 
> CONFIG_HIGHMEM4G=y
> CONFIG_HIGHMEM=y
> CONFIG_1GB=y
> 
> but I am only able to allocate 2 GB with a single malloc call.
> I tought it should be possible to allocate up to 2.9 GB of memory to a
> process, with this kernel settings.

Well, assuming you had no user-space code or data, or a stack, or any
shared libraries to fit into that space as well ;-)

Try shifting TASK_UNMAPPED_BASE down from 1GB to 0.5GB - that should give
you some more breathing room, though you'll never get to 2.9GB.

M.

