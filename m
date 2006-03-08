Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWCHWFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWCHWFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWCHWFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:05:44 -0500
Received: from mx1.suse.de ([195.135.220.2]:2796 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030224AbWCHWFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:05:43 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store buffers
Date: Wed, 8 Mar 2006 15:38:31 +0100
User-Agent: KMail/1.9.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, akpm@osdl.org,
       paulus@samba.org, bcrl@kvack.org, linux-kernel@vger.kernel.org
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain> <200603081521.19693.ak@suse.de> <1141855075.27555.14.camel@localhost.localdomain>
In-Reply-To: <1141855075.27555.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081538.32234.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 22:57, Bryan O'Sullivan wrote:
> On Wed, 2006-03-08 at 15:21 +0100, Andi Kleen wrote:
> 
> > I think doing it privately is the better solution because I don't think you 
> > have established it has an universal semantic that works
> > on all X86-64 systems.
> 
> No, I quoted chapter and verse of the relevant Intel and AMD x86_64 docs
> for you, complete with URLs and page numbers so it wouldn't take any
> effort to verify what I was asserting.
> 
> I don't know what else I could have done (it was enough for bcrl, at
> least), and you have come up any with suggestions as to what *would*
> satisfy you, so I'm stuck.

Hmm, I reread the thread and with the "i don't need a flush, just ordering" 
part of your description it makes sense.

My second objection still stands though. Maybe we should add this as
part of a generic portable PAT/WC infrastructure. But isolated
it doesn't make sense.

-Andi
