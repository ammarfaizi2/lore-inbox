Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWCHWBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWCHWBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWCHWBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:01:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64718 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030215AbWCHWBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:01:31 -0500
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store
	buffers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, ak@suse.de, paulus@samba.org, benh@kernel.crashing.org,
       bcrl@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 22:06:31 +0000
Message-Id: <1141855591.10606.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-08 at 13:31 -0800, Bryan O'Sullivan wrote:
> flush_wc() says nothing about whether {A,B,C} may be reordered with
> respect to each other, or whether {D,E} may, but it guarantees that
> {A,B,C} will make it off-CPU before {D,E}.  An arch that implements
> flush_wc() should make the stores occur immediately, if possible.

How is this different to mmiowb() ?


