Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289057AbSBDVJA>; Mon, 4 Feb 2002 16:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289125AbSBDVIk>; Mon, 4 Feb 2002 16:08:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49676 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289057AbSBDVId>; Mon, 4 Feb 2002 16:08:33 -0500
Message-ID: <3C5EF846.1070501@zytor.com>
Date: Mon, 04 Feb 2002 13:08:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Erik A. Hendriks" <hendriks@lanl.gov>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov> <m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com> <m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com> <m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com> <20020204134927.A5079@almesberger.net> <m1sn8h6ngb.fsf@frodo.biederman.org> <20020204220234.B5079@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:

> 
> Well, it keeps things simple for the kernel, and bootimg(8) needs
> to know the target architecture anyway. But there isn't really a
> design reason why it would have to use pages, agreed.
> 


I looked at this point at some time, and I found that it made it a lot
easier to write code to permute memory arbitrarily, as may be required.
  The reason is that you really want to keep an array that's O(N) in the
size of memory to keep track of where things are, and in order to do that,
realistically, you need to have some reasonably large granularity -- 4K
pages are just about right.

Of course, maybe I was just using a dumb algorithm... :)

	-hpa

