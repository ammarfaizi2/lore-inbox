Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSCEVrN>; Tue, 5 Mar 2002 16:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291074AbSCEVrD>; Tue, 5 Mar 2002 16:47:03 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:27918 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288748AbSCEVqy>; Tue, 5 Mar 2002 16:46:54 -0500
Date: Tue, 5 Mar 2002 22:46:50 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
Message-ID: <20020305224650.A1123@ucw.cz>
In-Reply-To: <E16i9mc-00043p-00@wagner.rustcorp.com.au> <3C84A34E.6060708@evision-ventures.com> <3C84AE16.A7F1ECCA@redhat.com> <20020305221933.A405@ucw.cz> <3C853BC9.EC553363@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C853BC9.EC553363@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Mar 05, 2002 at 04:42:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 04:42:33PM -0500, Jeff Garzik wrote:

> > Note that taskfiles are not being removed from IDE. Just direct (and
> > parsed and filtered) interface to userspace. Does the scsi midlayer
> > export the SCBs directly to userspace?
> 
> It should.
> 
> I think it's a mistake to remove the taskfile interface.
> 
> It provides a way for people to directly validate the lowest level IDE
> interface, without interference from upper layers.  It also provides
> access to userspace for important features that -should not- be in the
> kernel, like SMART monitoring and security features.

Well, Martin promised to reimplement it better later if there is demand
for it, and it seems there is. So I suppose it's going away only to be
replaced by something better.

There was a flamewar about this some time ago - whether the kernel
should or should not parse the taskfile access to prevent possibly
dangerous commands sent to the drive - if this is to be used for
validation, then all commands need to be allowed, which also will enable
to thin the code considerably.

-- 
Vojtech Pavlik
SuSE Labs
