Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277670AbRJIAuu>; Mon, 8 Oct 2001 20:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277672AbRJIAul>; Mon, 8 Oct 2001 20:50:41 -0400
Received: from pii.grimes-family.com ([209.177.4.67]:5453 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S277670AbRJIAud>; Mon, 8 Oct 2001 20:50:33 -0400
Date: Mon, 8 Oct 2001 20:51:12 -0400
From: "David M. Grimes" <dmgrime@appliedtheory.com>
To: Jim Crilly <noth@noth.is.eleet.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx panic
Message-ID: <20011008205112.C34894@appliedtheory.com>
In-Reply-To: <20011007163158.Q1555-100000@gerard> <1002508308.452.3.camel@warblade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1002508308.452.3.camel@warblade>; from noth@noth.is.eleet.ca on Sun, Oct 07, 2001 at 10:31:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 10:31:48PM -0400, Jim Crilly wrote:
> I changed AHC_NSEG from 128 to 512 and as expected the panic went away,
> but does this mean the default should be higher in the kernel or is
> there a real bug here? The main reason I wonder is because it ran fine
> on disk 0 but panic'd on disk 1.

Perhaps this is related (from 2.4.10-acX thread later on l-k):

--------
>From linux-kernel-owner@vger.kernel.org Mon Oct  8 18:34:32 2001
Subject: Re: linux-2.4.10-acX
To: mfedyk@matchmail.com (Mike Fedyk)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>

> > -   Elevator flow control
>
> Where can I find more information on this?

Read the ll_rw_blk diff. Basically it tries to avoid too many locked
buffers clogging up memory and killing the box. I'm not totally sure its
the right approach.
--------

Were there recent changes in ll_rw_blk which are being addressed by
"Elevator flow control"?  As suggested earlier in this thread, the cause
might be a few layers up, and this seemed relevant.

Can anyone confirm or shed any additional light on this?

  Dave

