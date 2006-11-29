Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758906AbWK2WrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758906AbWK2WrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758908AbWK2WrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:47:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:26902 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1758906AbWK2WrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:47:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nq8TyRyWO8M/YSthjbr4wPCbk/LhLN/8ZxVjcAq6C2Jdf6mkX/J2xnDmLiX1aPGGNxoCmEjkChwXE2lg20ZkjQtFD+kon4Z6Kv/VCgoo+YSqg64G5KApQxgU/fsyFvDowDaRuyj2sI0Ae072xOS3x56wUbKSKF5i5Q0kdFxGFuE=
Message-ID: <58cb370e0611291447y36430d5bta65176eb1198cdce@mail.gmail.com>
Date: Wed, 29 Nov 2006 23:47:04 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide_scsi: allow it to be used for non CD only
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20061129223518.19f6ef95@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061129144652.299f7919@localhost.localdomain>
	 <58cb370e0611291405j1e5f3eb1t4950ed0993b84c85@mail.gmail.com>
	 <20061129223518.19f6ef95@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 29 Nov 2006 23:05:56 +0100
> "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com> wrote:
>
> > Hi,
> >
> > Nowadays, you can dynamically change driver bound to a device using
> > sysfs and it works just fine for IDE, ie:
>
> This isn't the point of this change. The point is to do this at discovery
> time. If you do it later then many horrible things happen as the device

then "hdc=ide-cdrom" at a boot time should keep ide-scsi from
binding to hdc for all cases (builtin/modular ide-cd/ide-scsi)

> names and renames itself while udev goes boom.

Uh?  I hope that udev people are informed
about these horrible things...

/dev/hdc stays there all the time
/dev/sr? addition/removal should be handled
by udev otherwise it looks like a udev bug

> Its a small clean patch and it'll solve the problem nicely until
> drivers/ide dies.

No strong feelings here about the patch.  It is indeed a clean hack. ;)
I just wanted to point out that there are already more flexible ways
to achieve the same thing.

Bart
