Return-Path: <linux-kernel-owner+w=401wt.eu-S965114AbWLTOve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWLTOve (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWLTOve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:51:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50632 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965114AbWLTOve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:51:34 -0500
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
From: Arjan van de Ven <arjan@infradead.org>
To: David Wragg <david@wragg.org>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       bcrl@kvack.org
In-Reply-To: <871wmuab01.fsf@wragg.org>
References: <787b0d920612192140o37a28e8fnccdd51670cb9a766@mail.gmail.com>
	 <878xh2aelz.fsf@wragg.org>
	 <1166622487.3365.1386.camel@laptopd505.fenrus.org>
	 <871wmuab01.fsf@wragg.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 15:51:29 +0100
Message-Id: <1166626290.3365.1412.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 14:38 +0000, David Wragg wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> > if all you care is the number of context switches, you can use the
> > following system tap script as well:
> >
> > http://www.fenrus.org/cstop.stp
> 
> Thanks, something similar to that might well have solved my original
> problem.  
> 
> (When I try the script, stap complains about the lack of the kernel
> debuginfo package, which of course doesn't exist for my self-built
> kernel.  After hunting around on the web for 10 minutes, I'm still no
> closer to resolving this.  But I look forward to playing with
> systemtap once I get past that problem.)

what worked for me is copying the "vmlinux" file to /boot as
/boot/vmlinux-`uname -r`

(strace the stap program to see what it tries to load)



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

