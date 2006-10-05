Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWJEVo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWJEVo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWJEVoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:44:22 -0400
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:23688 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751411AbWJEVoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:44:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=d89kL34HJG7sxg8FpEq0VI6qrgEL5P0kjZY420BlVonCkTA5BcBdxkD4vFbAhP22abfRPKlxzx4ejfOzdoPZwCPUmtodaVC2K9MaFbbbPH8DFvx+S9LzB6tMpwX/WCrekBo7qtOeHlnVSs0U1SjU62CSwOIP1dhByDJiS208iWM=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: uml: use DEFCONFIG_LIST to avoid reading host's config
Date: Thu, 5 Oct 2006 23:41:13 +0200
User-Agent: KMail/1.9.1
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <11600785071661-git-send-email-blaisorblade@yahoo.it> <20061005213754.GC6790@ccure.user-mode-linux.org>
In-Reply-To: <20061005213754.GC6790@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052341.13341.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 23:37, Jeff Dike wrote:
> On Thu, Oct 05, 2006 at 10:01:47PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > This should make sure that, for UML, host's configuration files are not
> > considered, which avoids various pains to the user. Our dependency are
> > such that the obtained Kconfig will be valid and will lead to successful
> > compilation - however they cannot prevent an user from disabling any boot
> > device, and if an option is not set in the read .config (say
> > /boot/config-XXX), with make menuconfig ARCH=um, it is not set. This
> > always disables UBD and all console I/O channels, which leads to
> > non-working UML kernels, so this bothers users - especially now, since it
> > will happen on almost every machine
> > (/boot/config-`uname -r` exists almost on every machine). It can be
> > workarounded with make defconfig ARCH=um, but it is non-obvious and can
> > be avoided, so please _do_ merge this patch.
> >
> > Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>
> Acked-by: Jeff Dike <jdike@addtoit.com>
>
> Paolo - send this to Andrew as well so it doesn't get lost.
Yep, doing that separately in next batch - I'm sending to Andrew 14 patches, 
this one is still in the queue with other 10 patches, then there are the UBD 
ones (about 10 right now, will shrink the number maybe).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
