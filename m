Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272942AbRIRJHh>; Tue, 18 Sep 2001 05:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273230AbRIRJH1>; Tue, 18 Sep 2001 05:07:27 -0400
Received: from t2.redhat.com ([199.183.24.243]:45816 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272942AbRIRJHM>; Tue, 18 Sep 2001 05:07:12 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3BA69421.6020304@foogod.com> 
In-Reply-To: <3BA69421.6020304@foogod.com>  <E15ixGu-0006ym-00@the-village.bc.nu> 
To: Alex Stewart <alex@foogod.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Sep 2001 10:07:25 +0100
Message-ID: <20391.1000804045@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alex@foogod.com said:
> >>1) Be able kill -9 processes from "D" state.

> Please note that there is a reason why the "D" state exists, and it is
>  because there are certain times when interrupting a process can have
> significant consequences on the integrity of the entire filesystem (or
>  other global resource) and must not be allowed for consistency.  As
> it  happens, most of the conditions which cause processes to get
> "stuck" in  disk-wait state (usually because of hardware issues)
> happen to be  exactly the places where it's most difficult to work
> around this (at  least for physically-backed filesystems, less so for
> NFS et al)

What you say is true - implementing proper cleanup code for the case where
an operation is interrupted is complex and not always reasonably possible.

But that's an exceedingly poor excuse for not bothering to do so, in many
situations.

--
dwmw2

Filesystems are hard. Let's go shopping.

