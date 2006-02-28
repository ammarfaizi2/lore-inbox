Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWB1R55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWB1R55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWB1R55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:57:57 -0500
Received: from mx.pathscale.com ([64.160.42.68]:24532 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932283AbWB1R54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:57:56 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Jes Sorensen <jes@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <yq08xrvhkee.fsf@jaguar.mkp.net>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <yq08xrvhkee.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 09:57:55 -0800
Message-Id: <1141149475.24103.18.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 05:01 -0500, Jes Sorensen wrote:

> Could you explain why the current mmiowb() API won't suffice for this?
> It seems that this is basically trying to achieve the same thing.

It's a no-op on every arch I care about:

#define mmiowb()

Which makes it useless.  Also, based on the comments in the qla driver,
mmiowb() seems to have inter-CPU ordering semantics that I don't want.
I'm thus hesitant to appropriate it for my needs.

	<b

