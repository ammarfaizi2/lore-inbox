Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWHUFGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWHUFGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 01:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWHUFGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 01:06:00 -0400
Received: from main.gmane.org ([80.91.229.2]:27825 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965055AbWHUFF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 01:05:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Date: 21 Aug 2006 08:05:41 +0300
Message-ID: <5dirkmhe56.fsf@attruh.keh.iki.fi>
References: <20060820003840.GA17249@openwall.com> <5dwt933ku5.fsf@attruh.keh.iki.fi> <1156097428.4051.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181108174.pp.htv.fi
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Ar Sul, 2006-08-20 am 10:52 +0300, ysgrifennodd Kari Hurtta:
> > Perhaps stupid suggestion:
> > 
> > Should there be new signal for 'failure to drop privileges' ?
> > ( perhaps SIGPRIV or is this name free )
> > 
> > By default signal terminates process.  
> 
> Programs are allowed (and now and then do) intentionally let a setuid
> fail. A custom selinux or audit rule might be appropriate but that kind
> of hackery is not.

Commented code/patch used SIGKILL.  By allocating new signal programs
_are_ allowed intentionally let a setuid fail.

/ Kari Hurtta

