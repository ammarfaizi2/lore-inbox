Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422705AbWGNSwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422705AbWGNSwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161292AbWGNSwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:52:01 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:23931 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161287AbWGNSv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:51:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=NmrHXiV2cC1+fI4v+t8XFUjz+3TmpZ8R0aoRfXm0Mwi8c/YLyA2hoDIZ3rh9kkhcHwNT1ugqI6WuSgIypo9sjcvip4TSClaOP2/iWWZBYt/hT8dPnNSckT3D0bPRl71DQfZZXv7zmrrPGVvA3Gm5fw/EIu7d9NGgFSrGAWcp4Y0=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] UML build broken everywhere?
Date: Fri, 14 Jul 2006 20:52:05 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Garzik <jeff@garzik.org>, jdike@karaya.com,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <44B79AB9.3020401@garzik.org> <44B7A007.2010204@garzik.org>
In-Reply-To: <44B7A007.2010204@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607142052.05666.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 July 2006 15:45, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > I tried to build 2.6.17 and 2.6.17.4 UML on x86-64 with the attached
> > .config on a Fedora Core 5 OS, and it broke:
>
> I just verified that ARCH=um on 32-bit x86 is also broken, with the same
> build errors, on 2.6.17, 2.6.17.4, and 2.6.18-rc1-gitX (latest).
>
> 	Jeff
Jeff (Garzik), the above error is specific to glibc 2.4. There is a workaround 
patch (which is wrong, but makes UML compile - and the affected code is not 
normally used except for debugging).

Jeff (Dike), please choose one of the "simple" patches I suggested (comment 
out offending code, for instance) since you (correctly) deferred the real fix 
(incorporating klibc's setjmp implementation) to later.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
