Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWHOMU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWHOMU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWHOMU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:20:29 -0400
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:10899 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932257AbWHOMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:20:28 -0400
Date: Tue, 15 Aug 2006 07:20:26 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060815122026.GA7422@vino.hallyn.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com> <20060814220651.GA7726@sergelap.austin.ibm.com> <m1r6zirgst.fsf@ebiederm.dsl.xmission.com> <20060815020647.GB16220@sergelap.austin.ibm.com> <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815114946.GA7267@vino.hallyn.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge E. Hallyn (serge@hallyn.com):
> > Make it an arbitrary length bitfield with a defined byte order (little
> > endian, probably). Bits at offsets greater than the length of the
> > bitfield are defined to be zero. If the kernel encounters a set bit that
> > it doesn't recognizes, fail with EPERM. If userspace attempts to set a
> > bit that the kernel doesn't recognize, fail with EINVAL.
> > 
> > It's extensible (as new capability bits are added, the length of the
> > bitfield grows), backward compatible (as long as there are no unknown
> > bits set, it'll still work) and secure (if an unknown bit is set, the
> > kernel fails immediately, so there's no chance of a "secure" app running
> > with less privileges than it expects and opening up a security hole).
> 
> Sounds good.
> 
> The version number will imply the bitfield length, or do we feel warm
> fuzzies if the length is redundantly encoded in the structure?

nm, 'encoded in the structure' clearly is silly.

-serge
