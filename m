Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUILCa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUILCa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 22:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUILCa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 22:30:29 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:53396 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268406AbUILCa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 22:30:28 -0400
Date: Sat, 11 Sep 2004 19:29:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: anton@samba.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, ak@suse.de, iwamoto@valinux.co.jp,
       haveblue@us.ibm.com
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
Message-Id: <20040911192935.150fb951.pj@sgi.com>
In-Reply-To: <20040911185522.GA493@wotan.suse.de>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
	<20040911082834.10372.51697.75658@sam.engr.sgi.com>
	<20040911141001.GD32755@krispykreme>
	<20040911100731.2f400271.pj@sgi.com>
	<20040911185522.GA493@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> My prefered solution would be to never actually remove the zone datastructure,
> but just make them zero size when their memory is gone.  ...
> 
> This should also allow cpumemset to work.

Since cpusets doesn't stash zone pointers, it doesn't care.
It just stashes cpu masks (bitmaps) and node masks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
