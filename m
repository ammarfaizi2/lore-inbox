Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWJWVC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWJWVC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWJWVC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:02:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:8547 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751678AbWJWVC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:02:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f0h7dfccmFJXCbICTaGI9mOZzYeEj5MkCPJoQw6Ac5lutEPHdb4+MpB/acvYIfiZcvlDDA9SyJsD2iwV3ahWysmvqAxR9L6nxW6kVSs3qJP5DsJsBCnKUcQTf+kj5zTBzWznAG8Q0nIbBUcAenpxIxgIXIFxirLaJ4swkvxqews=
Message-ID: <69304d110610231402k7913df63l7e493f95b5d92911@mail.gmail.com>
Date: Mon, 23 Oct 2006 23:02:54 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Avi Kivity" <avi@qumranet.com>, "Arnd Bergmann" <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/13] KVM: vcpu execution loop
In-Reply-To: <453D27F8.8020509@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453CC390.9080508@qumranet.com> <200610232141.45802.arnd@arndb.de>
	 <453D230D.7070403@qumranet.com> <200610232229.41934.arnd@arndb.de>
	 <453D27F8.8020509@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Avi Kivity <avi@qumranet.com> wrote:
> Arnd Bergmann wrote:
> > On Monday 23 October 2006 22:16, Avi Kivity wrote:
> >
> >>> This looks like you should simply put it into a .S file.
> >>>
> >>>
> >>>
> >> Then I lose all the offsetof constants down the line.  Sure, I could do
> >> the asm-offsets dance but it seems to me like needless obfuscation.
> >>
> >
> > Ok, I see.
> >
> > How if you pass &vcpu->regs and &vcpu->cr2 to the functions instead of
> > kvm_vcpu?
> >
> >
>
> I could do that, but I feel that's more brittle.  I might need more (or
> other) fields later on.  It will also cost me more  pushes on the stack
> (no real performance or space impact, just C64-era frugality).

maybe thats the mindsent needed to make these virtual cpu patches
without eating away all the cpu power with more than needed
abstractions ;)

-- 
Greetz, Antonio Vargas aka winden of network

http://network.amigascne.org/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
