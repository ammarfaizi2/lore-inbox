Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbUKRCHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbUKRCHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUKRCE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:04:57 -0500
Received: from holomorphy.com ([207.189.100.168]:6863 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262369AbUKRCCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 21:02:23 -0500
Date: Wed, 17 Nov 2004 18:02:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Thiago Robert dos Santos <robert@lisha.ufsc.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remap_page_range
Message-ID: <20041118020215.GA3217@holomorphy.com>
References: <32825.150.162.62.34.1100724226.squirrel@150.162.62.34>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32825.150.162.62.34.1100724226.squirrel@150.162.62.34>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 06:43:46PM -0200, Thiago Robert dos Santos wrote:
>   I'm having a problem with remap_page_range in the 2.6 kernel series. I
> use remap_page_range inside the mmap function of a module I wrote in
> order to map a given device's memory into user space.
>   Apparently, everything works fine but I just can't access the device's
> memory (even tough I get a valid point from the mmap system call). This
> is the mmap function I wrote:
> static int
> pcimap_mmap (struct file *filp, struct vm_area_struct *vma)
> {

(1) set PG_reserved on all struct pages covering the physical region
(2) set VM_RESERVED|VM_IO in vma->vm_flags


-- wli
