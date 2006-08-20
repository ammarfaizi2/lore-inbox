Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWHTRtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWHTRtV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWHTRtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:49:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9356 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751094AbWHTRtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:49:20 -0400
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5dwt933ku5.fsf@attruh.keh.iki.fi>
References: <20060820003840.GA17249@openwall.com>
	 <5dwt933ku5.fsf@attruh.keh.iki.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:10:28 +0100
Message-Id: <1156097428.4051.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 10:52 +0300, ysgrifennodd Kari Hurtta:
> Perhaps stupid suggestion:
> 
> Should there be new signal for 'failure to drop privileges' ?
> ( perhaps SIGPRIV or is this name free )
> 
> By default signal terminates process.  

Programs are allowed (and now and then do) intentionally let a setuid
fail. A custom selinux or audit rule might be appropriate but that kind
of hackery is not.

