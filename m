Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWH0SIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWH0SIP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWH0SIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:08:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:30407 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932221AbWH0SIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:08:14 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
Date: Sun, 27 Aug 2006 20:07:47 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060827084417.918992193@goop.org> <44F1CC67.8040807@goop.org> <1156700663.3034.118.camel@laptopd505.fenrus.org>
In-Reply-To: <1156700663.3034.118.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272007.47741.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> your worst case scenario would be if the segment override would make it
> a "complex" instruction, so not parallel decodable. That'd mean it would
> basically cost you 6 or 7 instruction slots that can't be filled...
> while an and and such at least run nicely in parallel with other stuff.
> I don't know which if any processors actually do this, but it's rare/new
> enough that I'd not be surprised if there are some.

On AMD K7/K8 a segment register prefix is a single cycle penalty.

I couldn't find anything in the Intel optimization manuals on it, but I assume
it's also not dramatic.

-Andi
