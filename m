Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbSI0SyC>; Fri, 27 Sep 2002 14:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbSI0SyC>; Fri, 27 Sep 2002 14:54:02 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:2827 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262588AbSI0SyB>; Fri, 27 Sep 2002 14:54:01 -0400
Date: Fri, 27 Sep 2002 19:59:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020927195919.A4635@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven> <20020927175510.B32207@infradead.org> <200209271809.g8RI92e6002126@turing-police.cc.vt.edu> <20020927191943.A2204@infradead.org> <200209271854.g8RIsPe6002510@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209271854.g8RIsPe6002510@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, Sep 27, 2002 at 02:54:25PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 02:54:25PM -0400, Valdis.Kletnieks@vt.edu wrote:
> By the same token, at that point you can download the kernel source and
> build it without LSM.  What I showed was a way to bypass the iptables
> rules set up *WITHOUT REPLACING A MODULE* (which might be detected by
> tripwire, or totally refused because the LSM rejects any writes in /lib/modules).

insmod doesn't require modules to be in /lib/modules.  Anyway I could even change
the device name _after_ it was loaded.  this is linux and not BSD..

Given that we really want to fine-grained control who's netdevice can get what
names we'd` better place a hook in dev_alloc_name.

And that's my whole point: LSM adds random hooks all over the place without
even thinking what they intend to protect.

