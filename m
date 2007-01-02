Return-Path: <linux-kernel-owner+w=401wt.eu-S1754943AbXABUTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbXABUTN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbXABUTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:19:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:11609 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754943AbXABUTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:19:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lt0sp6r0YMApDtTli1ZM/uhX+k78IjUtzYi9QrdHbJrbh3f2KCpIqOfkAXntpVPEzYd7CAbuDwz2ERYVQBqHS6hHNu0af2FEG3fldD6XyAQ1tDOPoj/bC3muoRgCum11KZDve5xXHDzUTqwuJE6FGAHRu7wnVhKiJg2LR6Ptgqw=
Message-ID: <58cb370e0701021219l162406cax8116402e55feeac5@mail.gmail.com>
Date: Tue, 2 Jan 2007 21:19:10 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] atiixp: Old drivers/ide layer driver for the ATIIXP hang fix
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20070102155752.78f6a01e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070102155752.78f6a01e@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> When the old IDE layer calls into methods in the driver during error
> handling it is essentially random whether ide_lock is already held. This
> causes a deadlock in the atiixp driver which also uses ide_lock internally
> for locking.
>
> Switch to a private lock instead.
>
> Signed-off-by: Alan Cox <alan@redhat.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
