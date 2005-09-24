Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVIXP2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVIXP2o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 11:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVIXP2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 11:28:44 -0400
Received: from nevyn.them.org ([66.93.172.17]:5023 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932157AbVIXP2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 11:28:44 -0400
Date: Sat, 24 Sep 2005 11:28:37 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: mingo@elte.hu, roland@redhat.com, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
Subject: Re: Process with many NPTL threads terminates slowly on core dump signal
Message-ID: <20050924152837.GA27140@nevyn.them.org>
Mail-Followup-To: Michael Kerrisk <mtk-lkml@gmx.net>, mingo@elte.hu,
	roland@redhat.com, linux-kernel@vger.kernel.org,
	michael.kerrisk@gmx.net
References: <20206.1127391230@www22.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20206.1127391230@www22.gmx.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 02:13:50PM +0200, Michael Kerrisk wrote:
> I first noticed this happening on receipt of a SIGXCPU (since the
> program is designed to consume infinite CPU time).  However, I then
> determined that the behaviour occurs on receipt of any signal that
> can generate a core dump.

You might want to try using /proc/profile (profile= option) to see
where all the kernel time is going?


-- 
Daniel Jacobowitz
CodeSourcery, LLC
