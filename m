Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbUBPIW0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUBPIW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:22:26 -0500
Received: from gate.in-addr.de ([212.8.193.158]:60649 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265420AbUBPIWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:22:24 -0500
Date: Mon, 16 Feb 2004 09:22:22 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: dm core patches
Message-ID: <20040216082222.GG20998@marowsky-bree.de>
References: <1076690681.2158.54.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1076690681.2158.54.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-02-13T11:44:41,
   James Bottomley <James.Bottomley@steeleye.com> said:

> - fatal: error cannot be retried
> - retryable: error may be retried
> 
> and possibly
> 
> - informational: This is dangerous, since it's giving information about
> a transaction that actually succeeded (i.e. we'd need to fix drivers to
> recognise it as being uptodate but with info, like sector remapped)

I don't think we need informational errors. The meaning of this seems
pretty difficult to define, and it's bound to have annoying semantics. I
also can't come up with a case where you would want to use that ;-)

> Then, we also have a error origin indication:
> 
> - device: The device is actually reporting the problem
> - transport: the error is a transport error
> - driver: the error comes from the device driver.
> 
> So dm would know that fatal transport or driver errors could be
> repathed, but fatal device errors probably couldn't.
> 
> Any that I've missed?

No, I think those were the ones which we were discussing at KS2003 too.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

