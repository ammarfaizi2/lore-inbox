Return-Path: <linux-kernel-owner+w=401wt.eu-S1751699AbXAVLiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbXAVLiV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbXAVLiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:38:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:42069 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbXAVLiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:38:20 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sjYh8R/22NFJxbRPPTodbMpzX2Hf/VDt2nq303rcOvkCxdzgv74EjMX8E0luobhqO3k7Lls8aIN10/NWUi/+rzED5/ZN6pGeNkG7WrzValvUFJqJB2UBly/JbLTcH47tqQE09Dw5FRHTbQOGEPxyY20RKWRRT4s1pTaT3cMSqKw=
Message-ID: <9e0cf0bf0701220338i14ad4bd0k1194864fdf399ff4@mail.gmail.com>
Date: Mon, 22 Jan 2007 13:38:18 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: 7eggert@gmx.de, "Russell King" <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 03/26] Dynamic kernel command-line - arm
Cc: "Bernhard Walle" <bwalle@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E1H7dMw-0000hd-H6@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7EFbN-34r-3@gated-at.bofh.it> <7EFbV-34r-45@gated-at.bofh.it>
	 <7EGhI-4Rq-11@gated-at.bofh.it> <7EGKC-5vh-15@gated-at.bofh.it>
	 <E1H7dMw-0000hd-H6@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/07, Bodo Eggert <7eggert@gmx.de> wrote:
> Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> > On 1/18/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >> On Thu, Jan 18, 2007 at 01:58:52PM +0100, Bernhard Walle wrote:
> >> > 2. Set command_line as __initdata.
>
> >> You can't.
> >>
> >> > -static char command_line[COMMAND_LINE_SIZE];
> >> > +static char __initdata command_line[COMMAND_LINE_SIZE];
> >>
> >> Uninitialised data is placed in the BSS.  Adding __initdata to BSS
> >> data causes grief.
>
> > There are many places in kernel that uses __initdata for uninitialized
> > variables.
> >
> > For example:
>
> > static int __initdata is_chipset_set[MAX_HWIFS];
> >
> > So all these current places are wrong?
> > If I initialize the data will it be OK.
>
> objdump -t vmlinux |grep -3 is_chipset_set suggests that it's placed
> into .init.data here, not into .bss.

Russell ?
