Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTAJNC3>; Fri, 10 Jan 2003 08:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbTAJNC3>; Fri, 10 Jan 2003 08:02:29 -0500
Received: from holomorphy.com ([66.224.33.161]:58264 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265094AbTAJNC2>;
	Fri, 10 Jan 2003 08:02:28 -0500
Date: Fri, 10 Jan 2003 05:11:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
Subject: Re: small migration thread fix
Message-ID: <20030110131100.GS23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Robert Love <rml@tech9.net>
References: <200301101346.03653.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301101346.03653.efocht@ess.nec.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 01:46:03PM +0100, Erich Focht wrote:
> the small patch fixes a potential problem in the migration thread for
> the case that the first CPU in the cpus_allowed mask of a process is
> offline. Please consider applying it to your trees.

I'm not mingo, but I can say this looks sane. My only question is
whether there are more codepaths that need this kind of check, for
instance, what happens if someone does set_cpus_allowed() to a cpumask
with !(task->cpumask & cpu_online_map) ?


Thanks,
Bill
