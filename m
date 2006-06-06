Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWFFXeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWFFXeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWFFXeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:34:36 -0400
Received: from ns1.suse.de ([195.135.220.2]:59575 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751353AbWFFXeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:34:36 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 01:32:32 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Don Zickus <dzickus@redhat.com>,
       shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <20060606162201.f0f9f308.akpm@osdl.org> <44860F7B.2040105@goop.org>
In-Reply-To: <44860F7B.2040105@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606070132.32532.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Or does this also tie into other uses of the performance registers which
> may be set per-CPU?

That's it. The registration is to properly share performance registers
between oprofile, nmi watchdog and other users.

-Andi

