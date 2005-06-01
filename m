Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVFANrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVFANrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVFANrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:47:07 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:20627 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261377AbVFANrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:47:03 -0400
Date: Wed, 1 Jun 2005 15:46:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: XIAO Gang <xiao@unice.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
Message-ID: <20050601134643.GC29116@wohnheim.fh-wedel.de>
References: <429D5E79.2010707@unice.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429D5E79.2010707@unice.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 June 2005 09:06:33 +0200, XIAO Gang wrote:
> 
> I would like to make a security suggestion.
> 
> There are many length variables in the kernel, locally declared as "len" 
> or "length", either as "int", "unsigned int" or "size_t". However, 
> declaring a length as "int" leads easily to an erroneous situation, as 
> the author (or even a code checker) might make the implicite hypothesis 
> that the length is positive, so that it is enough to make a sanity check 
> of the kind
> 
> if (length > limit) ERROR;
> 
> which is not enough.
> 
> On the other hand, when a variable is named "len" or "length", it is 
> usually used for length and never should go negative. So could I suggest 
> that the declarations of these variables to be uniformized to "size_t", 
> via a gradual but sysmatic cleanup?

Could be.  Can you pick an example and send a patch for it?

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown
