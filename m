Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVGFTsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVGFTsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVGFTpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:45:52 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:56617 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262181AbVGFOwh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:52:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kDS+CFjOrMs0n2HZYPpGHvNFVm77+QboScQIAqoEZBDI5rHfh2VoIeJhH0dhJQ+4jOd2ZZK9NnZ38dr+ExBX1x6VBlE/ZHiRBkTa2hQtL1wD8t7aF1V6VzwgbX5BipcC/Obieti3zBXPmPRZ8zw+30V2INHyP5QB82sueL0GbMY=
Message-ID: <ea6b1902050706075248674f97@mail.gmail.com>
Date: Wed, 6 Jul 2005 16:52:34 +0200
From: Alexis Ballier <alexis.ballier@gmail.com>
Reply-To: Alexis Ballier <alexis.ballier@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2 - Inconsistent kallsyms data
In-Reply-To: <42CBE05F.4090706@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
	 <42CB8088.1090508@ppp0.net>
	 <ea6b190205070602091b50e204@mail.gmail.com>
	 <42CBE05F.4090706@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that fixed it. However, there was no problem with rc1 with the
same .config.





2005/7/6, Paulo Marques <pmarques@grupopie.com>:
> Alexis Ballier wrote:
> > Hi !
> >
> > I have a problem building the rc2 (or rc3, whatever ;) )
> >
> > Here is the end of the log :
> >
> > [...]
> > Inconsistent kallsyms data
> > Try setting CONFIG_KALLSYMS_EXTRA_PASS
> > make: *** [vmlinux] Erreur 1
> 
> Can you try to change this setting in scripts/kallsyms.c:
> 
> #define WORKING_SET             1024
> 
> to somethig like:
> 
> #define WORKING_SET            65536
> 
> If this fixes it, then it is a known problem and the fix is already in
> -mm. The fix is more complex than this, however.
> 
> --
> Paulo Marques - www.grupopie.com
> 
> It is a mistake to think you can solve any major problems
> just with potatoes.
> Douglas Adams
> 


-- 
Alexis Ballier.
