Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWBJRXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWBJRXQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWBJRXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:23:16 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:51410 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751333AbWBJRXP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:23:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=klXWK97FnbufPvfcxBsFm3CzdNa4muVwhUf1ZtesdEhlKaIHsjZAM7gTEdtfwXxzErmhiAIAj6PRltrJVpeStWrx0nevhMIq2QJH4iZ3bZtG3p4FsTfvovQTaTuhLbsrw4ZhsPKFODyQIlPGpkx6y/mXJqCztJUkDXuwqe0D5KE=
Message-ID: <986ed62e0602100923k7238072dib76162f5babba246@mail.gmail.com>
Date: Fri, 10 Feb 2006 09:23:14 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: disabling libata
Cc: Imre Gergely <imre.gergely@astral.ro>, linux-kernel@vger.kernel.org
In-Reply-To: <20060210141130.GE28676@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EC97C6.10607@astral.ro>
	 <20060210141130.GE28676@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> Why would you want to do that? SATA are driven by libata and the disks
> turn up as SCSI devices. There's no way around that (yet).

"Yet"? I haven't been following things closely enough, but I got the
impression that the long-term plan was something like this:

1. Move all the IDE drivers over to libata (Alan Cox has a patch to do
this, at least part of that patch is in -mm, and I'm already running
this flawlessly on one of my systems -- it's not debugged yet, but
none of the bugs happen to hit me). Yes, this means *all* ATA hard
drives become /dev/sd*, not just SATA.

2. Reorganize the Kconfig menus so that ATA stuff is no longer a
subsection of SCSI.

3. Rename /dev/sd* to /dev/disk*.

Of course, I could be mistaken (in which case, please feel free to correct me).
--
-Barry K. Nathan <barryn@pobox.com>
