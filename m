Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTL2GxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 01:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTL2Gw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 01:52:59 -0500
Received: from holomorphy.com ([199.26.172.102]:43188 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262782AbTL2Gw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 01:52:58 -0500
Date: Sun, 28 Dec 2003 22:52:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mfedyk@matchmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, phillips@arcor.de
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031229065240.GU22443@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>, mfedyk@matchmail.com,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Anton Ertl <anton@mips.complang.tuwien.ac.at>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	phillips@arcor.de
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it> <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org> <m1smj596t1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0312272046400.2274@home.osdl.org> <20031228163952.GQ22443@holomorphy.com> <20031229003631.GE1882@matchmail.com> <20031229025507.GT22443@holomorphy.com> <Pine.LNX.4.58.0312282000390.11299@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312282000390.11299@home.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 08:09:17PM -0800, Linus Torvalds wrote:
> I didn't see the patch itself, but I spent some time talking to Daniel
> after your talk at the kernel summit. At least I _think_ it was him I was 
> talking to - my memory for names and faces is basically zero.
> Daniel claimed to have it working back then, and that it actually shrank
> the kernel source code. The basic approach is to just make PAGE_SIZE
> larger, and handle temporary needs for smaller subpages by just
> dynamically allocating "struct page" entries for them. The size reduction
> came from getting rid of the "struct buffer_head", because it ends up
> being just another "small page".
> Daniel, details?

I also heard something about this from daniel. The description I was
given implied rather different functionality, and raised rather serious
questions about the implementation he didn't have adequate answers for.
I also never saw code, despite months of occasional discussions about it.

I did get a positive reaction from you at KS, and I've also been
slaving away at keeping this thing current and improving it when I can
for a year. Would you mind telling me what the Hell is going on here?

I guess I already know I'm screwed beyond all hope of recovery, but I
might as well get official confirmation.

-- wli
