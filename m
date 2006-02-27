Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWB0Wj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWB0Wj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWB0WjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:39:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:5765 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964861AbWB0Wig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:38:36 -0500
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 10/39] [PATCH] i386/x86-64: Dont IPI to offline cpus on shutdown
Date: Mon, 27 Feb 2006 23:37:54 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ashok Raj <ashok.raj@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
References: <20060227223200.865548000@sorel.sous-sol.org> <20060227223344.160102000@sorel.sous-sol.org>
In-Reply-To: <20060227223344.160102000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602272337.56509.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 23:32, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> So why are we calling smp_send_stop from machine_halt?

I don't think that one is really suitable for stable since it's
a relative obscure problem and the fix is not fully clear. Also it might
have side effects. Shouldn't be merged.

-Andi
