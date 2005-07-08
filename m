Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVGHNQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVGHNQC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVGHNNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:13:47 -0400
Received: from gate.in-addr.de ([212.8.193.158]:35042 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262648AbVGHNM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:12:57 -0400
Date: Fri, 8 Jul 2005 15:12:30 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Provide better printk() support for SMP machines [try #2]
Message-ID: <20050708131230.GH5674@marowsky-bree.de>
References: <1491.1120594224@warthog.cambridge.redhat.com> <31737.1120826172@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31737.1120826172@warthog.cambridge.redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-07-08T13:36:12, David Howells <dhowells@redhat.com> wrote:

> The attached patch prevents oopses interleaving with characters from other
> printks on other CPUs by only breaking the lock if the oops is happening on
> the machine holding the lock.
> 
> It might be better if the oops generator got the lock and then called an inner
> vprintk routine that assumed the caller holds the lock, thus making oops
> reports "atomic".
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

After some discussion on IRC (me asking dumb questions) and reviewing
the code I'm in infinite favour of this patch. It clearly is a step in a
mucho desireable direction.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

