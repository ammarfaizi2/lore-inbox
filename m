Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVAMVDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVAMVDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVAMVAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:00:32 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:13338 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261670AbVAMU6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:58:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=C/1s70SJNElfUQF742K0E0BkCRJro9enJJd7En4SioJb7ZarqtkvVNyGSn9QRVrChNfkv46IZaOerSLupJrlbOu/lrkeeVGbINsS6wefpWX7lbi+XdnTYTGmDdNkVB8P4wggI6GTQB1DFgq0yLISQG5uy8yl+lwXz4LqImQNVro=
Message-ID: <36b714c805011312586718520f@mail.gmail.com>
Date: Thu, 13 Jan 2005 15:58:34 -0500
From: Brian Waite <linwoes@gmail.com>
Reply-To: Brian Waite <linwoes@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc: fix idle with interrupts disabled
In-Reply-To: <200501120407.j0C477s1019067@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501120407.j0C477s1019067@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005 01:41:19 +0000, Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> ChangeSet 1.2369, 2005/01/11 17:41:19-08:00, tglx@linutronix.de
> 
>         [PATCH] ppc: fix idle with interrupts disabled
> 
>         The idle-thread-preemption-fix.patch in mm1/2 leads to a stalled box on PPC
>         machines which do not provide a powersave function and therefor poll the
>         idle loop with interrupts disabled.  The patch reenables interrupts.
There is still a stall with PPC  boxes that have powersave enabled. I
use a 74xx based board and unless I disable powersave
(ppc_md.power_save=NULL), I get a stall at:
NET: Registered protocol family 2

Reverting default_idle to prepatch form I still see the hang. I think
it is somewhere else in the patchset. Still looking....

Thanks
Brian
