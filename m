Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263303AbUJ3CUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbUJ3CUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 22:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbUJ3CQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 22:16:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:12507 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263698AbUJ3COz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 22:14:55 -0400
To: Roland Fehrenbacher <rf@q-leap.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops on x86_64 2.4.27 with 8GB RAM and sata_sil
References: <16770.9441.410275.546384@gargle.gargle.HOWL.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Oct 2004 04:14:42 +0200
In-Reply-To: <16770.9441.410275.546384@gargle.gargle.HOWL.suse.lists.linux.kernel>
Message-ID: <p73oeilymst.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Fehrenbacher <rf@q-leap.de> writes:

> Hi,
> 
> I have appended the output of ksymoops obtained from an Oops on an
> Opteron Server that has 8GB RAM. The Oops occurs when disc access to a
> SATA disk is attempted. The disk sits on a SIL3114 controller. There
> is no oops and perfect behaviour if I specify mem=4032M as a kernel
> parameter. Anybody got an idea what is going on?

Enable CONFIG_GART_IOMMU

The kernel warned you about this BTW at boot, but you chose to ignore
the warning.

-Andi 
