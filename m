Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWB1KBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWB1KBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWB1KBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:01:31 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:38100 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751292AbWB1KBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:01:31 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
References: <1140841250.2587.33.camel@localhost.localdomain>
From: Jes Sorensen <jes@sgi.com>
Date: 28 Feb 2006 05:01:29 -0500
In-Reply-To: <1140841250.2587.33.camel@localhost.localdomain>
Message-ID: <yq08xrvhkee.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bryan" == Bryan O'Sullivan <bos@pathscale.com> writes:

Bryan> On some platforms, a regular wmb() is not sufficient to
Bryan> guarantee that PCI writes have been flushed to the bus if write
Bryan> combining is in effect.

Bryan> This change introduces a new macro, wc_wmb(), that makes this
Bryan> guarantee.

Bryan,

Could you explain why the current mmiowb() API won't suffice for this?
It seems that this is basically trying to achieve the same thing.

Cheers,
Jes
