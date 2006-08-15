Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWHOMEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWHOMEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbWHOMEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:04:22 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:38789 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751447AbWHOMEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:04:21 -0400
Date: Tue, 15 Aug 2006 07:04:19 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: KaiGai Kohei <kaigai.kohei@gmail.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060815120419.GA7372@vino.hallyn.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com> <20060814220651.GA7726@sergelap.austin.ibm.com> <44E1153D.9000102@ak.jp.nec.com> <20060815021612.GC16220@sergelap.austin.ibm.com> <44E14406.7020208@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E14406.7020208@ak.jp.nec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting KaiGai Kohei (kaigai.kohei@gmail.com):
> Hi,
> 
> >>See
> >>http://www.kaigai.gr.jp/index.php?FrontPage#b556e50d
> >>http://www.kaigai.gr.jp/pub/fscaps-1.0-kg.src.rpm
> >>
> >>The later SRPM package includes the cap_file.c.
> >>It will be a good sample of using libcaps.
> >
> >And this has a version number built in, as Eric was asking for.
> 
> _LINUX_CAPABILITY_VERSION defined as 0x19980330 is used for this.
> Is there a possibility to be changed future, isn't it?
> For example, when we think 32-bit width is not enough.
> 
> >My tools were purely for testing, and just kept everything as simple as
> >possible.  So I'll happily port the kernel patch to use your tools  :)
> >
> >For that matter I see you have your own kernel patch.  Would you mind
> >submitting that to lkml as an alternative to mine?
> 
> I have no plan to submit now. It'll be called "Re-investment of wheel".

Assuming you meant reinvention, not at all.  We want to get the best
patch in.

> # In addition, I'm currently busy to hack PostgreSQL. :D

Ok, well thanks for taking a look at this one.

> I hope to confirm one more point.
> Endian conpatibility is considered in the patches?

Not yet.  Will add that and a check of the cap bitfield length as
mentioned in another email.

thanks,
-serge
