Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVCNFxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVCNFxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 00:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVCNFxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 00:53:07 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:19772 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261156AbVCNFxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 00:53:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QhRHEPHCK7eQdzrS94/rt816LBJDXIfuO6QBZiXS7cPjzUW5dePT68mzXRyNkEiV1Hn5s0Hkpez3p825sVTeHVtpiqwLPncZgvRT+lMqJqr3pI//eVG7j5kqudJEsxjfP0tQFyBPN9qHbh/CCj3OLlwD+7PveS7VLR2MF7d7tJQ=
Message-ID: <9e473391050313175229f1a3d0@mail.gmail.com>
Date: Sun, 13 Mar 2005 20:52:54 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16948.60419.257853.470644@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <9e473391050312075548fb0f29@mail.gmail.com>
	 <16948.56475.116221.135256@wombat.chubb.wattle.id.au>
	 <9e47339105031317193c28cbcf@mail.gmail.com>
	 <16948.60419.257853.470644@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 12:42:27 +1100, Peter Chubb
<peterc@gelato.unsw.edu.au> wrote:
> >>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:
> 
> >>  The scenario I'm thinking about with these patches are things like
> >> low-latency user-level networking between nodes in a cluster, where
> >> for good performance even with a kernel driver you don't want to
> >> share your interrupt line with anything else.

Instead of making up a new API what about making a library of calls
that emulates the common entry points used by device drivers. The
version I did for UML could take the same driver and run it in user
space or the kernel without changing source code. I found this very
useful.

-- 
Jon Smirl
jonsmirl@gmail.com
