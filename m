Return-Path: <linux-kernel-owner+w=401wt.eu-S932337AbXAIVI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbXAIVI6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbXAIVI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:08:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:25248 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbXAIVI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:08:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=VpAw+z2DhVyN8/JJFsB4S/rZQW0A2MR/TE44A9irLgDvfNaA7nNtolclYMMj/jt/iq4qlrqYtTD2X29g4HDeUxrb41NsZw9f8Qslb6ea2medldm17aNnYHrNDFk85VqKU5/3h9OK9x2b6rplycirL203mqkJsiqKhlygrKIAdVE=
Date: Tue, 9 Jan 2007 21:06:50 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Frederik Deweerdt <frederik.deweerdt@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Re: 2.6.20-rc3-mm1] BUG: at kernel/sched.c:3415 sub_preempt_count()
Message-ID: <20070109210649.GC13656@slug>
References: <20070104220200.ae4e9a46.akpm@osdl.org> <45A3A96B.7090802@gmail.com> <20070109152757.GB13656@slug> <45A4000C.2060502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45A4000C.2060502@gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 09:50:20PM +0100, Maciej Rutecki wrote:
> Frederik Deweerdt napisał(a):
> 
> > See:
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/hot-fixes/
> > This should fix it.
> > Regards,
> > Frederik
> >>
> 
> I don't use reiser4 or cpufreq, see my .config.
The generic_sync_sb_inodes() function which gets fixed by the
reiser4-sb_sync_inodes-fix patch isn't only used by reiser4. The
spinlock unbalance is most likely responsible for the preempt_count
mismatch.

Regards,
Frederik
> 
> -- 
> Maciej Rutecki <maciej.rutecki@gmail.com>
> http://www.unixy.pl
> LTG - Linux Testers Group
> (http://www.stardust.webpages.pl/ltg/wiki/)
> 


