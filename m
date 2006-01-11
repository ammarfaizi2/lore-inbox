Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWAKVHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWAKVHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWAKVHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:07:40 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:46016 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932247AbWAKVHj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:07:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e/2j9a6j0afH772DXgfgSsfZaOSosDmyg/oljJxZmhVxUPsYbSxeqCL3oWgZnpnnTnXZsiYhHVG/b04B9fXmI3iulMRIls9h0Sd9b6NbU7lZFhRiZ/WnIc0WcRgFWUtHzKPWuqi7OXULAXBIHVLfZLXp3alHp3eaRjgCz7qzm2A=
Message-ID: <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
Date: Wed, 11 Jan 2006 16:07:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <1135575997.14160.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051225212041.GA6094@hansmi.ch>
	 <200512252304.32830.dtor_core@ameritech.net>
	 <1135575997.14160.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sun, 2005-12-25 at 23:04 -0500, Dmitry Torokhov wrote:
>
> > As far as the hook itself - i have that feeling that it should not be
> > done in kernel but via a keymap.
>
> While I understand your feeling, it's a bit annoying in this specific
> case because previous models did this in hardware and all mac keymaps
> already account for that. Knowing how nasty it has been to get mac
> keymaps updated and in a good shape, and to get distros to properly get
> them, it makes a lot of sense to have this small hook in the kernel that
> makes the USB keyboard behave exactly like the older ADB couterparts.
>

Ok, I am looking at the patch again, and I have a question - do we
really need these 3 module parameters? If the goal is to be compatible
with older keyboards then shouldn't we stick to one behavior?

--
Dmitry
