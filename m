Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVI0NoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVI0NoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVI0NoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:44:21 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:28860 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964939AbVI0NoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:44:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Oi5rEZkWjbxiv7Sk3j+ZXLnFNeHOje/8raUs6qv/2QQPnpi2bs3JZ9W02/d7axFsYPEaK8WwNkpPs7twFm++WFpfbth1RszPmIXJ5sDeLYw5EcabjH4kOwJWv69OSG4Ez1T2k+6V3LKftsTPSb8b+7wkHmQyHp14qxkmgfNrf2g=
Date: Tue, 27 Sep 2005 09:40:55 -0400
From: Florin Malita <fmalita@gmail.com>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: nsxfreddy@gmail.com, akpm@osdl.org, davem@davemloft.net,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, bonding-devel@lists.sourceforge.net
Subject: Re: [PATCH] channel bonding: add support for device-indexed
 parameters
Message-Id: <20050927094055.7953a832.fmalita@gmail.com>
In-Reply-To: <200509270711.j8R7BunP014387@death.nxdomain.ibm.com>
References: <20050927012444.be5d5311.fmalita@gmail.com>
	<200509270711.j8R7BunP014387@death.nxdomain.ibm.com>
X-Mailer: Sylpheed version 2.1.2 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 00:11:56 -0700
Jay Vosburgh <fubar@us.ibm.com> wrote:
> 
> Florin Malita <fmalita@gmail.com> wrote:
> [...]
> >How can you load a module multiple times on _any_ distro?
> 
> 	modprobe -obond0 bonding mode=your-favorite-mode
> 	modprobe -obond1 bonding mode=some-other-mode
> 
> 	and so on.  This is in the modprobe man page, and is described
> in the bonding documentation (found in the kernel documentation or at
> http://sourceforge.net/projects/bonding).  It is admittedly somewhat
> grotty, but it works.  

OK, I see this capability has been in module-init-tools since the 0.8
days. Doesn't apply to any 2.4/modutils based system tough.

> 
> >Not being able to set a (different) preferred
> >interface/primary for each bond device makes it unacceptable for
> >deployment in our environment.
> 
> 	How are you configuring bonding?  The current SuSE distros, for
> example, will do the multiple module load stuff automatically in the
> sysconfig scripts.  This is described in the current bonding
> documentation.

Our systems are RHEL3 based so unfortunately the naming trick above
doesn't work. 

But it does work on RHEL4 so admittedly, having this workaround
available for recent distros removes the urgency for a fix.

Thanks
Florin
