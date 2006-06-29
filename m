Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWF2Isl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWF2Isl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 04:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWF2Isl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 04:48:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55265 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751246AbWF2Isk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 04:48:40 -0400
Date: Thu, 29 Jun 2006 01:47:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: ak@suse.de, 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, drepper@redhat.com, roland@redhat.com,
       jakub@redhat.com
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Message-Id: <20060629014736.7b02af7c.pj@sgi.com>
In-Reply-To: <20060628090058.GA15328@elte.hu>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	<20060621081539.GA14227@elte.hu>
	<20060627224433.fb726e0c.pj@sgi.com>
	<200606281053.15681.ak@suse.de>
	<20060628090058.GA15328@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> it's useful in terms of userspace uniformity.

Yes.  It's an important property of Linux that it
provides a common, portable API for all arch's,
except where the obvious semantics (not performance)
of a call are necessarily arch-specific.

Just coding up system calls for those arch's that
happen to run a particular call super-fast, even
though the call makes logical sense on all arch's,
would lead to API chaos and impede application
portability.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
