Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316766AbSE0V5L>; Mon, 27 May 2002 17:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSE0V5K>; Mon, 27 May 2002 17:57:10 -0400
Received: from holomorphy.com ([66.224.33.161]:63658 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316766AbSE0V5K>;
	Mon, 27 May 2002 17:57:10 -0400
Date: Mon, 27 May 2002 14:56:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
Message-ID: <20020527215632.GR14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de> <3CF23893.207@loewe-komp.de> <1022513156.1126.289.camel@irongate.swansea.linux.org.uk> <acu82e$7qn$1@cesium.transmeta.com> <20020527173306.C15560@redhat.com> <1022539831.4123.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 02:22:22PM -0700, H. Peter Anvin wrote:
>>> Well, if you can't fork a new process because that would push you into
>>> overcommit, then you usually can't actually do anything useful on the
>>> machine.

On Mon, 2002-05-27 at 22:33, Benjamin LaHaise wrote:
>> Just use vfork or clone + exec.  It's faster and uses less memory.

On Mon, May 27, 2002 at 11:50:31PM +0100, Alan Cox wrote:
> In the general case a fork doesn't cause too much overcommit. Most of
> the binary is mapped read-only as is a lot of the library space. Since
> its read only and backed by a file it has zero cost. If you mprotect it
> then you pay at mprotect time

If you're willing to take a feature request, I'd be much obliged if the
pagetable memory were also accounted.


Thanks,
Bill
