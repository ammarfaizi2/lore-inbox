Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132894AbRAXWAq>; Wed, 24 Jan 2001 17:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132941AbRAXWAg>; Wed, 24 Jan 2001 17:00:36 -0500
Received: from [64.64.109.142] ([64.64.109.142]:19218 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S132894AbRAXWAQ>; Wed, 24 Jan 2001 17:00:16 -0500
Message-ID: <3A6F5050.8627570C@didntduck.org>
Date: Wed, 24 Jan 2001 16:59:44 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jie Zhou <jiezhou@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: question about compiling the kernel
In-Reply-To: <OF8F6A4D7C.6EC3D10C-ON852569DE.0077CDA2@somers.hqregion.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jie Zhou wrote:
> > > 3. After I run the /sbin/lilo, it says the new kernel is added to the
> > > system. HOwever when I restart the system and go into the labeled kernel
> > > I choose, the system gets stucked after these two lines:
> > > Loading kernel.......................
> > > Uncompressing Linux...OK, booting the kernel.
> > >
> > > Can you give me some advice on this. Thanks a lot for your kind reply..
> >
> > Make certain you compiled the kernel for the proper CPU type (ie. don't
> > try to run a Pentium II kernel on a 486)
>
> Thank you very much. My computer is a Pentium machine, should be able to
> run any kernel. :-(

Not true.  If you compile the kernel for a Pentium Pro or higher cpu,
GCC will include some instructions (cmovxx in particular) that do not
exist on earlier processors.  Since the fault handlers are not set up
yet when booting the kernel, this results in a silent crash.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
