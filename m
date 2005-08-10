Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVHJU31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVHJU31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbVHJU31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:29:27 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:51368 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030254AbVHJU31 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:29:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PyDQCUD3qz2uixOnjRyyooF1zzRVMlrtCStqAB2S0TUCzGWfZkaYOGRd7wD8vWm9jrWzu9VtnWcVtJARl8ixjkjt3M0LTENyM+oyYYJyp199sNJYYLCZmef1td8RktBub1/cuwKn0tkrSZd3PoZkN/lNaBgWfb78+uFMFeJArN0=
Message-ID: <60f2b0dc05081013296a0a7938@mail.gmail.com>
Date: Wed, 10 Aug 2005 22:29:26 +0200
From: Olivier Fourdan <fourdan@gmail.com>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: PATCH: Assume PM Timer to be reliable on broken board/BIOS
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42E6C86F.3010503@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4uGpt-2Y3-15@gated-at.bofh.it> <42E6C86F.3010503@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/05, Robert Hancock <hancockr@shaw.ca> wrote:
> > In a nutshell, sometimes, the PIT/TSC timer runs 3x too fast [1]. That
> > causes many issues, including DMA errors, MCE, and clock running way too
> > fast (making the laptop unusable for any software development). So far,
> > no BIOS update was able to fix the issue for me.
> 
> Shouldn't this be looked into further rather than adding this
> workaround? Surely Windows is using the PIT as well, so there must be
> some way to get it to behave properly..

Sorry for the late follow up. Well, the timer management in Windows
depends on the HAL used. By default, it's the ACPI HAL that is used in
this laptop.

I did re-install Windows by forcing the "Standard PC"  HAL in Windows
XP installation and, without ACPI, Windows exhibits the exact same
problem as Linux or any other system: The clock runs 3 times too fast
in Windows too...

So my guess is that the HAL ACPI in Windows does more or less the same
thing that does my patch (updated, available here:
http://www.xfce.org/~olivier/r3000), it calibrates the PIT timer based
on the ACPI (PM) timer.

Cheers,
Olivier.
