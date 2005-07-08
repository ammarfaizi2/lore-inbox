Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVGHTnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVGHTnC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVGHTld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:41:33 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:15660 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262787AbVGHTjD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:39:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lqLXnCcoKRRI/EF2Ubd9RNwY76wQRolQWSUf+dP1erLFbI2b+icPF2fJGcF86UD2SlTFQMLeSVCbpWcgfFGgJnO594Oy8yetpQjzGzKsnSApbnZmSqD0W1EK2HLeHaKha1x73s5tDtPITPky2iM+nqE5E1sRAh9icP+bOfdz1Eg=
Message-ID: <161717d505070812385dea6099@mail.gmail.com>
Date: Fri, 8 Jul 2005 15:38:36 -0400
From: Dave Neuer <mr.fred.smoothie@gmail.com>
Reply-To: mr.fred.smoothie@pobox.com
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Real-Time Preemption -RT-V0.7.51-17 - Keyboard Problems
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050708191326.GA6503@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42CEC7B0.7000108@cybsft.com> <20050708191326.GA6503@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/05, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > Ingo,
> >
> > I have an issue with keys VERY SPORADICALLY repeating, SOMETIMES, when
> > running the RT patches.

<snip>

> > 2.6.12 doesn't seem to have the
> > problem at all, only when running the RT patches. It SEEMS to have
> > gotten worse lately.

<snip>

> > Adjusting the delay in the keyboard repeat seems to help. Any ideas?
> 
> hm. Would be nice to somehow find a condition that triggers it.

FWIW, I've had this problem from time to time on my Compaq Presario
x1010us laptop (which also uses the ICH-4 chipset) with several kernel
versions between 2.6.7 and 2.6.12, and I have _not_ been running the
RT patches (though I plan to start soon).

It seems to only happen when the laptop has been running for a while.
Also, X has been running each time. When it occurs, the stuck key
events follow the mouse focus from window to window, and in the few
cases where I'm able to either switch out of X to a different VT or
kill X, the keyboard is still "wedged" -- if I recall correctly,
switching VTs results in no keyboard events reaching that VT (as if X
is still consuming them). Can't remember what happens when I've
successfully killed X.

Again, happens uncommonly enough that I haven't put much effort into
debugging it.

Anyway, unless it's a similar but unlrelated bug, it's not _caused_ by RT.

Dave
