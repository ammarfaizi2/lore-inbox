Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422824AbWHYEDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbWHYEDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 00:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWHYEDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 00:03:33 -0400
Received: from ozlabs.org ([203.10.76.45]:49799 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422824AbWHYEDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 00:03:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17646.29510.296315.569294@cargo.ozlabs.ibm.com>
Date: Fri, 25 Aug 2006 13:49:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Dong Feng" <middle.fengdong@gmail.com>
Cc: ak@suse.de, "Christoph Lameter" <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Unnecessary Relocation Hiding?
In-Reply-To: <a2ebde260608241830p2d26b20bp6bfb9b1b5a267ec6@mail.gmail.com>
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
	<Pine.LNX.4.64.0608241125140.4394@schroedinger.engr.sgi.com>
	<17646.14056.102017.127644@cargo.ozlabs.ibm.com>
	<a2ebde260608241830p2d26b20bp6bfb9b1b5a267ec6@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dong Feng writes:

> Sorry for perhaps extending the specific question to a more generic
> one. In which cases shall we, in current or future development,
> prevent gcc from knowing a pointer-addition in the way RELOC_HIDE? And
> in what cases shall we just write pure C point addition?

Where you are saying to gcc "you think this variable is at this
address, but I know it's actually at this other address over here" you
should use RELOC_HIDE.  Where the addition is being used to get the
address of some part of the object (so the resulting address is still
within the object) you can just use plain addition.

Paul.
