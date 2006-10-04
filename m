Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWJDWlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWJDWlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 18:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWJDWlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 18:41:51 -0400
Received: from mail.suse.de ([195.135.220.2]:37304 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751197AbWJDWlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 18:41:51 -0400
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: removed sysctl system call - documentation and timeline
References: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 05 Oct 2006 00:41:47 +0200
In-Reply-To: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
Message-ID: <p73u02jzot0.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> writes:

> Hi,
> 
> With recent kernels I'm getting a lot of warnings about programs using
> the removed sysctl syscal.
> 
> Examples (after 5 min of uptime here) :
> root@dragon:/home/juhl# dmesg | grep "used the removed sysctl system
> call" | sort | uniq
> warning: process `dd' used the removed sysctl system call
> warning: process `ls' used the removed sysctl system call
> warning: process `touch' used the removed sysctl system call
> 
> and more can be found...

They all only use a single sysctl (kernel/version). IMHO that
one should be just emulated and the rest -ENOSYSed. There used
to be a slightly buggy patch for that in tree.

I think that would give all the advantages (dropping of the 
numerical name space) with 99+% backwards compatibility

-Andi
