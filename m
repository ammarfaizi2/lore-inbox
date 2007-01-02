Return-Path: <linux-kernel-owner+w=401wt.eu-S964860AbXABMhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbXABMhV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbXABMhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:37:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:45601 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964860AbXABMhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:37:19 -0500
In-Reply-To: <1167713825.6165.54.camel@localhost.localdomain>
References: <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org> <20070101.005714.35017753.davem@davemloft.net> <1167710760.6165.32.camel@localhost.localdomain> <20070101.203043.112622209.davem@davemloft.net> <1167713825.6165.54.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <69fccc6b0149520efdb3edc478e98304@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, dmk@flex.com, wmb@firmworks.com,
       hch@infradead.org, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 13:36:19 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Simple system tools should not need to interpret binary data in
>> order to provide access to simple structured data like this, that's
>> just stupid.
>
> I would agree with you if the data was properly typed in the first 
> place
> but it's not,

OF device tree properties are "properly typed" just fine -- it's
just that only the intended consumers of the data know what to
expect, you certainly can't derive the data structures from just
looking at the data in one instance of a property.

Put another way, if you know what you are looking for in the
device tree, you can decode a property just fine -- if you're
given a random property on the other hand, you can never get
any better than the generic property structure of "array of bytes".


Segher

