Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266916AbSKKS3M>; Mon, 11 Nov 2002 13:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSKKS3M>; Mon, 11 Nov 2002 13:29:12 -0500
Received: from fmr01.intel.com ([192.55.52.18]:43510 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266916AbSKKS3K>;
	Mon, 11 Nov 2002 13:29:10 -0500
Message-ID: <002e01c289b1$2c83b140$77d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: <vamsi@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200211082100.gA8L0Q515460@linux.intel.com> <20021111133548.A16731@in.ibm.com>
Subject: Re: Multiple kprobes per address
Date: Mon, 11 Nov 2002 10:35:56 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was really only concerned with multiple consumers of kprobes.  So if
I were to create some tool that used kpobes to hook into the kernel, and
someone else were to create another tool that solved a different problem
but also used kprobes then the two tools wouldn't play nice with each other.

    -rustyl

----- Original Message -----
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, November 11, 2002 12:05 AM
Subject: Re: Multiple kprobes per address


> Hi,
>
> On Fri, Nov 08, 2002 at 01:00:26PM -0800, Rusty Lynch wrote:
> > I noticed that kprobes is designed around the idea of only allowing
> > a single probe point per probe address.  Why not allow multiple probe
> > points for a given probe address?  Is it a way of limiting complexity?
> >
> We didn't think it would be useful and conceptually, it is simpler to
> think of one probe at an address.
>
> > It looks like it would be fairly straight forward to change
get_kprobe(addr)
> > to be get_kprobes(addr) where it returns a list of probe points
associated
> > with the address, and then tweak do_int3 to work through the entire
list.
> > Would such a change be acceptable?
> >
> It will be trivial to add this, but why? Is there a good reason
> for wanting to do this (multiple kprobes at same address) as opposed
> to doing all you want done on a probe hit in a single handler?
>
> Regards,
> Vamsi.
> --
> Vamsi Krishna S.
> Linux Technology Center,
> IBM Software Lab, Bangalore.
> Ph: +91 80 5044959
> Internet: vamsi@in.ibm.com

