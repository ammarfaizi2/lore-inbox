Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278549AbRJXPHn>; Wed, 24 Oct 2001 11:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278550AbRJXPHd>; Wed, 24 Oct 2001 11:07:33 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:38844 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278549AbRJXPHX>; Wed, 24 Oct 2001 11:07:23 -0400
Subject: Re: patch to exec_domain
From: Paul Larson <plars@austin.ibm.com>
To: Kjohn Sasitorn <kjohn@cs.utexas.edu>
Cc: lkml <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
In-Reply-To: <20011024093420.A6686@vampire.cs.utexas.edu>
In-Reply-To: <20011024093420.A6686@vampire.cs.utexas.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 24 Oct 2001 10:12:41 +0000
Message-Id: <1003918363.26207.2.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-24 at 14:34, Kjohn Sasitorn wrote:
> Currently, the personality(2) system call always returns the previous
> persona. However, according to the manpage, it should return the previous
> persona when successful and -1 otherwise. The following patch to
> lookup_exec_domain() should remedy this behavior:

Actually I think that problem was already fixed.  However, this looks
like it fixes another problem I've seen though where personality doesn't
return EINVAL if you pass it a bad personality.  Right fix, wrong bug :)

Thanks,
Paul Larson

