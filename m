Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWHHGCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWHHGCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWHHGCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:02:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:8331 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932190AbWHHGCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:02:03 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64:  Auto size the per cpu area.
Date: Tue, 8 Aug 2006 08:01:29 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com> <1155005284.3042.11.camel@laptopd505.fenrus.org> <m13bc7aidw.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m13bc7aidw.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608080801.29789.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 07:47, Eric W. Biederman wrote:
> 
> Now for a completely different but trivial approach.
> I just boot tested it with 255 CPUS and everything worked.
> 
> Currently everything (except module data) we place in
> the per cpu area we know about at compile time.  So
> instead of allocating a fixed size for the per_cpu area
> allocate the number of bytes we need plus a fixed constant
> for to be used for modules.
> 
> It isn't perfect but it is much less of a pain to
> work with than what we are doing now.

Yes makes sense.

However not that particular patch - i already changed that
code in my tree because I needed really early per cpu for something and
i had switched to using a static array for cpu0's cpudata.

I will modify it to work like your proposal.

-Andi
