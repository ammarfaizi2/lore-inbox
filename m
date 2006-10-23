Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWJWRmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWJWRmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWJWRmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:42:11 -0400
Received: from smtp101.plus.mail.re2.yahoo.com ([206.190.53.26]:35154 "HELO
	smtp101.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964970AbWJWRmI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:42:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent:Content-Transfer-Encoding;
  b=LWFGGpy6PNo0oIXItPB3RJRLhQjevzTW4qoNx5ApEJQTsj4qQogrGfjB65J/aapaM6zHYwheGQVdkYsAHOsbxR7/JsAtFU4h6stVqvyglm5G5zVLC8S3c4qyG3KJzLPp/LqE+QvZ7PfgNS3E+7W0MVS4tOykWCzSxtNGLwnZnnA=  ;
Date: Mon, 23 Oct 2006 14:24:11 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] do not compile Sony Vaio extras as a module per default
Message-ID: <20061023122411.GB4979@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
References: <20061022063924.GA7177@gollum.tnic> <Pine.LNX.4.61.0610221254220.3696@yvahk01.tjqt.qr> <20061022091054.3fc8596b.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20061022091054.3fc8596b.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 09:10:54AM -0700, Randy Dunlap wrote:
> On Sun, 22 Oct 2006 12:54:30 +0200 (MEST) Jan Engelhardt wrote:
> 
> > 
> > >--- current/drivers/acpi/Kconfig.orig	2006-10-21 10:02:23.000000000 +0200
> > >+++ current/drivers/acpi/Kconfig	2006-10-21 10:02:30.000000000 +0200
> > >@@ -262,7 +262,6 @@ config ACPI_SONY
> > > 	tristate "Sony Laptop Extras"
> > > 	depends on X86 && ACPI
> > > 	select BACKLIGHT_CLASS_DEVICE
> > >-	default m
> > > 	  ---help---
> > > 	  This mini-driver drives the ACPI SNC device present in the
> > > 	  ACPI BIOS of the Sony Vaio laptops.
> > 
> > Reason?
> 
> This is the third such patch/request that I recall for this
> one.  It's =m for Andrew (one of his machines).
> Otherwise the patch makes sense and should be merged...
> 
> ---
> ~Randy

We already turned off the Toshiba extras module some time ago since the majority
of us don't necessarily have the aforementioned machine (see commit
f9a204e1de73a7007de66fb289e1d64a7665c9b4 in Linus' tree) but if this one is
different, then so be it. I still think, though, that it makes more sense to
leave stuff turned on in case it is needed in the most profiles of kernel usage
and leave not so common features off and let people turn them on only for their
special case.

-- 
Regards/Gruﬂ,
    Boris.

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
