Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266030AbUAUSnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266032AbUAUSnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:43:43 -0500
Received: from palrel13.hp.com ([156.153.255.238]:39396 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266030AbUAUSnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:43:22 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16398.51269.149031.241526@napali.hpl.hp.com>
Date: Wed, 21 Jan 2004 10:43:17 -0800
To: Jes Sorensen <jes@trained-monkey.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for ia64
In-Reply-To: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 20 Jan 2004 07:23:49 -0500, Jes Sorensen <jes@trained-monkey.org> said:

  Jes> Hi,
  Jes> The new sort_extable and shares search_extable code doesn't work on
  Jes> ia64. I have introduced two new #defines that archs can define to avoid
  Jes> the common code being built. ARCH_HAS_SEARCH_EXTABLE and
  Jes> ARCH_HAS_SORT_EXTABLE.

  Jes> With this patch, 2.6.1-mm5 builds again on ia64.

What's this about?  Isn't the only reason this doesn't work because
the "insn" member is called "addr" on ia64?  If so, surely it would
make more sense to do a little renaming?

	--david
