Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVLFXZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVLFXZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVLFXZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:25:48 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:3939 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030287AbVLFXZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:25:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=USPfZuGVZGjxtZF74A2qFpXNRbXSgGbaIethtnM4bLk8N5iQYg62ekUV08e1jDVs6iXidin10yY+Co8KY0d9Nu1sEjBTyahbehtpizc/3q1ZeGR61TA8r6e/M9v1/+xjl7ONQ4hHRjmaDkeVuunTs9Rw9RmIjcrNZ4MuOqEEQ6I=
Message-ID: <c0a09e5c0512061525n1c1a472ci56eeef22a6d970b4@mail.gmail.com>
Date: Tue, 6 Dec 2005 15:25:46 -0800
From: Andrew Grover <andy.grover@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Gerst <bgerst@didntduck.org>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133907922.4136.218.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random>
	 <43944F42.2070207@didntduck.org> <20051206030828.GA823@opteron.random>
	 <4394696B.6060008@didntduck.org>
	 <1133894575.4136.171.camel@baythorne.infradead.org>
	 <1133897035.23610.32.camel@localhost.localdomain>
	 <1133907922.4136.218.camel@baythorne.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2005-12-06 at 19:23 +0000, Alan Cox wrote:
> > On Maw, 2005-12-06 at 18:42 +0000, David Woodhouse wrote:
> > > There's some work on reverse-engineering the BIOS so that you can
> > > hackishly poke 'new' modes into its tables, but it's still not a very
> > > good option.
> >
> > Especially as the BIOS interface at the low level for the analogue end
> > and the logic driving it is board specific. Intel have been fairly clear
> > why they use the BIOS interface.
>
> Have they? I haven't seen the excuse.
>
> I assume it's similar to the excuse for ACPI -- "although we _could_
> document the chips and allow board manufacturers to include simple
> tables which describe the way they're wired together (in which they have
> relatively little leeway), we'd rather hide it all behind some opaque
> blob and have you trust HardwareVendorCode to drive it instead of being
> able to write your own and debug it as you can with Free Software"?

Where possible ACPI does still use tables. For more complicated
configuration, ACPI uses easily-decompiled bytecodes. I think if the
graphics bios provided arch-neutral AML for doing all this
mode-setting stuff we'd be better off. Better than interpreting x86
real-mode BIOS code!

> Trusting the BIOS for this kind of thing isn't really much better than
> trusting any other binary-only piece of code, from a technical point of
> view. (Ignoring the licensing issues; we have indeed digressed). In
> fact, given the traditional quality of BIOS implementations, trusting
> the BIOS is far _worse_ than trusting any other piece of binary code.

You have to get a priori information about the system somewhere. With
ACPI at least it's not a complete mystery what the BIOS is doing,
unlike these video BIOSes.

-- Andy
