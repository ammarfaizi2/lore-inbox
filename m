Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVFUD1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVFUD1C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVFUD0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:26:17 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:64826 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261714AbVFUCeL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 22:34:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AXQUf09AKB6Xsiso4WqCkYzm/eKpkwyqrXke6rlxEIU4xw7zvqBhzOIekjqTmS3UuiUyZ8jwvxQwLpii9HqHYcJeu6O1gRTH6ArnOtLNoFMshSLp3H5SUJvFgXLOKtIpBqNNh0ksjmXo0CTwMhnXgtIWoLS6vtDue6Qu5/cNmLQ=
Message-ID: <b70d738005062019348a7e087@mail.gmail.com>
Date: Mon, 20 Jun 2005 19:34:10 -0700
From: Adam Morley <adam.morley@gmail.com>
Reply-To: Adam Morley <adam.morley@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: psmouse doesn't seem to reinitialize after mem suspend (acpi) when using i8042 on ALi M1553 ISA bridge with 2.6.11.11 or 2.6.12-rc5?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b70d738005061322453f4280d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b70d73800506051924546c8931@mail.gmail.com>
	 <b70d738005060821032cc1a4a@mail.gmail.com>
	 <b70d738005061322223fc7942@mail.gmail.com>
	 <200506140037.05242.dtor_core@ameritech.net>
	 <b70d738005061322453f4280d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/05, Adam Morley <adam.morley@gmail.com> wrote:
> On 6/13/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > On Tuesday 14 June 2005 00:22, Adam Morley wrote:
> > > Hi All,
> > >
> > > I hadn't heard anything from Dimitry in a few days, so I thought I'd
> > > resend and see if anyone else had any pointers for where I should
> > > look.  I'd still love to have a functional mouse post-mem suspend.
> > >
> >
> 
> Hi Dimitry,

Hi Dimitry + linux-kernel,

> > What we could try is to force PNP layer to re-enable the device, but
> > I don't have code for that yet.
> 
> Ok.  If you get it, let me know.  Thanks.  Now that transmeta is dead,
> I guess this might never happen.  Too bad, I really would love to be
> able to mem suspend this puppy.

I found a setting in the bios called "manual setting" for the pointing
device, under "advanced -> keyboard/mouse settings".  When set to
"manual setting," the button with a mouse picture on it (aka F3, when
pushed while Fn is held) will ... "jumpstart" the mouse, and it gets
picked up by psmouse again.  I don't know why it didn't work when I
had it set to "always enabled," or why it didn't used to work (I tried
"manual setting" when I was still using recompiled debian 2.6.8), but
it does now, with 2.6.11.11 even.

Perhaps the s3 suspend state confuses the always on setting of the
mouse and it doesn't "come back" or something.  Either way, this
setting seems to have fixed the one last nagging "feature" of the
p1120 running linux.  Minus the well-known CMS bug, which is
work-aroundable.  Now this p1120 is just dreamy with linux.

thanks for all the help.  Would an i8042.debug with the Fn+F3 pushing
help at all?  Perhaps it might tell us what's going on, and whether
this really is a "feature" of the p1120/ali m1533?

-- 
adam
