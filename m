Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTEEDha (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 23:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTEEDha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 23:37:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19522 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261878AbTEEDh2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 23:37:28 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4 && kexec
References: <20030502020149.1ec3e54f.akpm@digeo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 May 2003 21:46:51 -0600
In-Reply-To: <20030502020149.1ec3e54f.akpm@digeo.com>
Message-ID: <m1of2iawd0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm4/
> 
> 
> . Much reworking of the disk IO scheduler patches due to the updated
>   dynamic-disk-request-allocation patch.  No real functional changes here.
> 
> . Included the `kexec' patch - load Linux from Linux.  Various people want
>   this for various reasons.  I like the idea of going from a login prompt to
>   "Calibrating delay loop" in 0.5 seconds.
> 
>   I tried it on four machines and it worked with small glitches on three of
>   them, and wedged up the fourth.  So if it is to proceed this code needs
>   help with testing and careful bug reporting please.

The current state of the code is that APM is not expected to work.  The
user space tool needs a fix to pass the address of the APM entry points
to the new kernel.

But beyond that everything should work baring drivers which have
problems shutting themselves down and restarting.

Eric
