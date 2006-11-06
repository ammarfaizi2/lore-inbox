Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753435AbWKFQsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbWKFQsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbWKFQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:48:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:17932 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753435AbWKFQsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:48:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tm0pltZ2ocHdE7LG/ey0QNA+P1wVs4cRm+QGycjnW9JeMCUprJsjmc//D1AE64KuhSZScMuI79tAsSHCYuLRamWbw+tXVcCMLScP1HAzJH0BneHQU+5yB0aICz0lFB+hS1xzx4FtZdXt+Fgl95HPPHtVHXkidoIkMCv4k1rS0L0=
Message-ID: <d120d5000611060848k1f5fa2f7r7e78a0eca88a59ce@mail.gmail.com>
Date: Mon, 6 Nov 2006 11:48:03 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Dave Neuer" <mr.fred.smoothie@pobox.com>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>
In-Reply-To: <161717d50611060822w11e031ebra8f62d0fc5b02d69@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608232311.07599.dtor@insightbb.com>
	 <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
	 <200611030103.17913.dtor@insightbb.com>
	 <161717d50611060822w11e031ebra8f62d0fc5b02d69@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Dave Neuer <mr.fred.smoothie@pobox.com> wrote:
>
> As I said, I have had both keyboard and touchpad problems on this
> laptop (formerly more of the former, lately more of the latter);
> interestingly, after applying this patch I have had failures much less
> frequently (multiple instances of several days w/out failure w/ the
> laptop powered on continuously). Also interestingly, and
> unfortunately, that may be coincidence; I've discovered a use case
> that seems to reliably cause the touchpad to freeze up w/ or w/out the
> patch applied (selecting multiple items in modified file list in
> EasyTAG). Haven't looked into it yet, on the "hurts when I do this,"
> "then don't do that" theory, but when I have time to look at the
> EasyTAG code and try to reason about what's happening, I will.
>

It would be interesting to see dmesg of reloading psmouse module after
touchpad freezes:

echo 1 > /sys/module/i8042/parameters/debug
rmmod psmouse
modprobe psmouse

BTW, what video driver are you using?

-- 
Dmitry
