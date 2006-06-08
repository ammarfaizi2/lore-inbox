Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWFHH52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWFHH52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWFHH51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:57:27 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:41636 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S964787AbWFHH51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:57:27 -0400
Message-ID: <349753441.03000@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 8 Jun 2006 15:57:22 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Voluspa <lista1@comhem.se>
Cc: akpm@osdl.org, arjan@infradead.org, Valdis.Kletnieks@vt.edu,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix fastcall
Message-ID: <20060608075722.GA5515@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Voluspa <lista1@comhem.se>, akpm@osdl.org, arjan@infradead.org,
	Valdis.Kletnieks@vt.edu, diegocg@gmail.com,
	linux-kernel@vger.kernel.org
References: <349406446.10828@ustc.edu.cn> <20060604020738.31f43cb0.akpm@osdl.org> <1149413103.3109.90.camel@laptopd505.fenrus.org> <20060605031720.0017ae5e.lista1@comhem.se> <349560742.21407@ustc.edu.cn> <20060608093138.79f66acb.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608093138.79f66acb.lista1@comhem.se>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 09:31:38AM +0200, Voluspa wrote:
> On Tue, 6 Jun 2006 10:26:06 +0800 Fengguang Wu wrote:
> > On Mon, Jun 05, 2006 at 03:17:20AM +0200, Voluspa wrote:
> > > Patch:
> > > http://web.comhem.se/~u46139355/storetmp/adaptive-readahead-v14-linux-2.6.17-rc5-git-updated-june-04-2006.patch
> > 
> > It seems that the patch has some problem:
> [...]
> > The above statements was displaced, rendering the if() clause to fail all the time.
> > That defeats the small file optimization, for ra_thrash_bytes will remain small.
> 
> Which rendered all my testing invalid. Nice... It came about with the
> update-01to04of04 and must have elicited a "fuzz" that I neglected to
> check. 
> 
> Sorry to have caused you grief and extra work, Wu. I can only point 
> towards the _Caveat and preemptive Mea Culpa_.

Not bad ;-)
The stresses imposed forced me to think hard about the overheads
the adaptive readahead introduced. And also some areas that the
stock readahead has been good at.

me too, have some performance numbers, to be posted on the preferred thread.

Thanks,
Wu
