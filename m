Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269302AbUHaXRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269302AbUHaXRC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269268AbUHaXQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:16:38 -0400
Received: from relay01.kbs.net.au ([203.220.32.149]:36784 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S269277AbUHaXP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:15:28 -0400
Subject: Re: [2.6 patch]  kill __always_inline
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, ak@muc.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040831225244.GY3466@fs.tum.de>
References: <20040831221348.GW3466@fs.tum.de>
	 <20040831153649.7f8a1197.akpm@osdl.org>  <20040831225244.GY3466@fs.tum.de>
Content-Type: text/plain
Message-Id: <1093993946.8943.33.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 01 Sep 2004 09:12:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-09-01 at 08:52, Adrian Bunk wrote:
> On Tue, Aug 31, 2004 at 03:36:49PM -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@fs.tum.de> wrote:
> > >
> > > An issue that we already discussed at 2.6.8-rc2-mm2 times:
> > > 
> > > 2.6.9-rc1 includes __always_inline which was formerly in  -mm.
> > > __always_inline doesn't make any sense:
> > > 
> > > __always_inline is _exactly_ the same as __inline__, __inline and inline .
> > > 
> > > 
> > > The patch below removes __always_inline again:
> > 
> > But what happens if we later change `inline' so that it doesn't do
> > the `always inline' thing?
> > 
> > An explicit usage of __always_inline is semantically different than
> > boring old `inline'.

Excuse me if I'm being ignorant, but I thought always_inline was
introduced because with some recent versions of gcc, inline wasn't doing
the job (suspend2, which requires a working inline, was broken by it for
example). That is to say, doesn't the definition of always_inline vary
with the compiler version?

Regards,

Nigel

-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

