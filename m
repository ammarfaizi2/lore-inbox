Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVAHW7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVAHW7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVAHW7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:59:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:14043 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261240AbVAHW7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:59:45 -0500
Date: Sat, 8 Jan 2005 16:56:30 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/4][RFC] Genetic Algorithm Library
Message-ID: <20050108165630.4c4e2efa@localhost>
In-Reply-To: <41DFEBFE.1030602@andrew.cmu.edu>
References: <20050106100844.53a762a0@localhost>
	<41DFE8B7.9070909@andrew.cmu.edu>
	<41DFEBFE.1030602@andrew.cmu.edu>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Jan 2005 09:19:42 -0500
James Bruce <bruce@andrew.cmu.edu> wrote:

> Ok I've read the patch and see you do indeed have crossover; Now I have 
> a different question.  What is the motivation for generating two 
> children at once, instead of just one?    Genes values shouldn't get 
> "lost" since the parents are being kept around anyway.  Also, since the 
> parameters in general will not have a meaningful ordering, it might make 
> sense for the generic crossover to be the "each gene randomly picked 
> from one of the two parents" approach.  In practice  I've found that to 
> mix things up a bit better in the parameter optimization problems I've 
> done with GAs.

The intitial motivation for creating two children at once was so each
parent could pass on all of their genes.  The 75% of the parent's genes
might be in child A, but the other 25% would be in child B.  

Thinking about it more, there should be no reason that all of a parent's
genes have to be passed on in a child.  It would not be too difficult to
have each gene come randomly from one of the two parents.  I'll add that
in on the next rev of the patches. 

Thanks,
Jake 
