Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVAGUFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVAGUFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVAGUEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:04:55 -0500
Received: from waste.org ([216.27.176.166]:37322 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261588AbVAGUDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:03:19 -0500
Date: Fri, 7 Jan 2005 12:02:46 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andreas Steinmetz <ast@domdv.de>,
       Lee Revell <rlrevell@joe-job.com>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LAD mailing list <linux-audio-dev@music.columbia.edu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107200245.GW2940@waste.org>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de> <1104898693.24187.162.camel@localhost.localdomain> <20050107011820.GC2995@waste.org> <87brc17pj6.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87brc17pj6.fsf@sulphur.joq.us>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 11:54:05PM -0600, Jack O'Quin wrote:
> Note that sched_setschedule() provides no way to handle the mlock()
> requirement, which cannot be done from another process.

I'm pretty sure that part can be done by a privileged server handing
out mlocked shared memory segments.

The trouble with introducing something into the kernel is that once
done, it can't be undone. So you're absolutely going to meet
resistance to anything that can be a) done sufficiently in userspace
or b) can reasonably be done in a more generic manner so as to meet
the needs of a wider future audience. The onus is on the submitter to
meet these requirements because we can't easily kick out a broken API
after we accept it.

-- 
Mathematics is the supreme nostalgia of our time.
