Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVEaT2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVEaT2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVEaT2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:28:23 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:49709 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261228AbVEaT2S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:28:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TJpXIHZ/dAMYcs1G4lTm3vgpgHBKQOTxJfXi9tDcsQxu+YIVhZhjJCUM/uVv1A146wMBr9IFxK+2XqAEPMla3Kdj3Z2xBn2HTjshpbY57G8IEywaGe6f3OqMFvjfBWN791hsLLmNhptDJwAp2ZFArThyErLEFh1gbL3XlT4pnu4=
Message-ID: <d120d500050531122879868bae@mail.gmail.com>
Date: Tue, 31 May 2005 14:28:16 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
In-Reply-To: <20050531172204.GD17338@voodoo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
	 <20050530093420.GB15347@hout.vanvergehaald.nl>
	 <429B0683.nail5764GYTVC@burner>
	 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
	 <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/05, Jim Crilly <jim@why.dont.jablowme.net> wrote:
> On 05/31/05 01:03:31PM +0200, Joerg Schilling wrote:
> >
> > > And why again do you need stable SCSI addresses for my _USB_ drive?
> >
> > Well if the udev program was polite to users, it would also support
> > to edit /etc/default/cdrecord......
> >
> > ... if it _really_ does wat you like with /dev/ links, then it has all
> > the information that is needed to also maintain /etc/default/cdrecord
> 
> The rules and scripts that udev uses to name things can do anything since
> it runs in userland, so udev could easily edit /etc/default/cdrecord if
> someone took the time to write the script.
> 

Yes it could but why should it? The purpose of udev is to maintain
dynamic /dev. Do you want to have thoustands quirks in udev to cope
with bazillion configuration files for utilities whose authors refuse
to adopt standard naming convention [for the operating system in
question].

I do not understand why Joerg is so fixed on presenting SCSI interface
to userspace. Why when I mount just burned CD I can use /dev/scd0 but
for writing it I should say dev=5,4,0?? I do not really care that
internally X,Y,Z might or might not used, they should not be exposed
to userspace, especially since days when they could be used for static
device identification are long gone.

-- 
Dmitry
