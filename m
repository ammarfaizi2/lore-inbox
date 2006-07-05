Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWGEQjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWGEQjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWGEQjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:39:41 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:49438 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964861AbWGEQjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:39:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gidLxsq6RAgIRNpUpAqR7BjBhmsZnbajtjfNkFC9Fc2lqMTN8OajRdiGCtTBE3E1F5UqUh3GGIDVbaokkETKNCdy9+zAslmRnJwcXd7FYiIfGBJqYByPwIYMhTiAXU4e65rUrpEdaa5OlbaWHcjKr33JJpHBpkLXqWnQJlVllbc=
Message-ID: <a44ae5cd0607050939w5f6dc131v24c8ffc93e6f8baf@mail.gmail.com>
Date: Wed, 5 Jul 2006 09:39:38 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: 2.6.17-mm5 -- netconsole failed to send full trace
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <a44ae5cd0607042354s68b38d2bl11d638b282e4c918@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607030131x745b3106ydd2a4ca086cdf401@mail.gmail.com>
	 <20060703121717.b36ef57e.akpm@osdl.org>
	 <a44ae5cd0607042222w6a370b70ka2d75fab926a28be@mail.gmail.com>
	 <200607042349.05509.david-b@pacbell.net>
	 <a44ae5cd0607042354s68b38d2bl11d638b282e4c918@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/06, Miles Lane <miles.lane@gmail.com> wrote:
> On 7/4/06, David Brownell <david-b@pacbell.net> wrote:
> > On Tuesday 04 July 2006 10:22 pm, Miles Lane wrote:
> >
> > > > So we have a use-after-free in tasklet_action(), as a consequence of
> > > > unplugging a USB ethernet adapter.
> > >
> > > So far, all the kernels have crashed (back to Ubuntu's 2.6.15).
> >
> > Erm, exactly which USB ethernet adapter?  That would seem to be a
> > critical bit of info that's somehow been omitted...
> >
> > If it's the rtl8150 driver, that would be Petko's ...
>
> Linksys EtherFast 10/100 Compact Network Adapter (model USB100M).
> Yes, the rtl8150 driver loads when I insert the adapter.

Can someone tell me when the udev/hal support went into the kernel?
I tried compiling a 2.6.12, but when I booted it, Ubuntu 6.06 couldn't
run udev/hal, so my devices didn't get configured.  I loaded rtl8150
using modprobe, but no ethX device was created, so I couldn't test the
card.  I am attempting to determine how far back in the kernel history
I have to go to have this adapter not crash the system when I remove it.
It didn't crash 2.6.12, but it doesn't count if the driver isn't successfully
associated with the hardware, I suspect.

Thanks,
        Miles
