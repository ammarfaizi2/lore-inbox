Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271381AbTGXI43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 04:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271403AbTGXI43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 04:56:29 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:5639 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S271381AbTGXI42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 04:56:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre7: are security issues solved?
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain>
	<E19fGMZ-0000Zm-00@gondolin.me.apana.org.au>
	<20030723033505.145db6b8.davem@redhat.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 24 Jul 2003 11:11:34 +0200
In-Reply-To: <20030723033505.145db6b8.davem@redhat.com> (David S. Miller's
 message of "Wed, 23 Jul 2003 03:35:05 -0700")
Message-ID: <87u19cffw9.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> If I know your password is 7 characters I have a smaller
> space of passwords to search to just brute-force it.

This is not the real problem, IMHO.

If the counter is public, you can read it repeatedly to measure the
intervals between keypresses.  If you take pair-wise timing into
account, you can narrow the search space considerably.

There's a detailed paper about the issue:

  <http://www.ece.cmu.edu/~dawnsong/papers/ssh-timing.pdf> 

(Even if the title says SSH, it applies to the public counter scenario
as well.)
