Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933114AbWKMWtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114AbWKMWtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933115AbWKMWtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:49:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:55748 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933114AbWKMWtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:49:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=EBB71Wfddg6M5iowD6tgRdhu5/7nRlPcJrKSYvvha8k96Tl+tiH65xMb3tk9aaZas5Ast44GCA3wXGJ7Nsm7RvxVZhp/41SY3lnbzmUFcmWjl85Ww37HEcnbfkwpfpje68ps+WdGgGRmbH/HGkIAkiqlAMc4m40BHhmwVfeAStM=
Subject: Re: pcmcia: patch to fix pccard_store_cis Was:
	[SOLUTION/HACK/PUZZLED] pcmcia modem only works with cardmgr in recent
	2.6.15 kernel.
From: Romano Giannetti <romano.giannetti@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-pcmcia@lists.infradead.org,
       fabrice@bellet.info, linux-kernel@vger.kernel.org
In-Reply-To: <20061113135405.4e7874ac.akpm@osdl.org>
References: <20061001122107.9260aa5d.zaitcev@redhat.com>
	 <20061002003138.GB16938@isilmar.linta.de>
	 <1159794094.8246.2.camel@localhost>
	 <20061103160247.GB11160@dominikbrodowski.de>
	 <1163412159.11397.11.camel@localhost>
	 <20061113135405.4e7874ac.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 23:48:58 +0100
Message-Id: <1163458138.15921.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 13:54 -0800, Andrew Morton wrote:

> It doesn't sound like these problems will be fixed in the short term so
> yes, please let's get these into bugzilla so at least they don't get
> forgotten about and we have contact information filed away against
> particular problems.  One record per bug, please.

All right. Tomorrow I will try to find the time to file a bug. 

> I do have a debugging patch here which will give us better info about the
> above IRQ-handler conflict.  I'll probably push that into 2.6.19 - we seem
> to be getting a few of these lately.

But wait, I do not think this is really a relevant bug. It happens only
if I tart cardmgr, which is supposed it's not needed for newer kernels.
The problem here (as I stated in another mail in this thread) is that it
seems that the new pccardctl infrastructure miss the second function of
my card, registering and initialiazng just the first one. 


> > 
> > PS: can anyone point me to a tutorial on howto install a new kernael
> > easily on ubuntu? The procedure they point to (creating deb package,
> > installing, etc) are quite cumbersome. Anyway, I will try. 
> 
> Well it sounds like fixing these bugs is a long-term project.  So it would
> be fine if you were to wait until Ubuntu have a 2.6.19-based kernel
> available.

Uf. This will be at least six month. I really need my modem before than
that :-). I have an old external Robotics one, but well, it's a bit, you
know, big... I will try a newer kernel, I think that my problem is
simply that in ubuntu kernel all is modular, and make install do not
generate a initrd by default. 

> But otoh I don't think Ubuntu release bleeding-edge kernel packages, so
> that may be quite some time in the future.  So if you're able to work out
> how to build and install a kernel.org kernel then that would help things
> along a bit.  

Will try. If anyone can suggest a recipe before I test zillions of
reboots, it will be very welcome.

Thanks,
	Romano


