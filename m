Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312394AbSCYL2S>; Mon, 25 Mar 2002 06:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312402AbSCYL2J>; Mon, 25 Mar 2002 06:28:09 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:61703
	"HELO marcus.pants.nu") by vger.kernel.org with SMTP
	id <S312393AbSCYL1y>; Mon, 25 Mar 2002 06:27:54 -0500
Subject: Re: ANN: New NTFS driver (2.0.0/TNG) now finished.
To: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 25 Mar 2002 03:50:26 -0800 (PST)
Cc: aia21@cam.ac.uk (Anton Altaparmakov), linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <6451.1017045127@redhat.com> from "David Woodhouse" at Mar 25, 2002 08:32:07 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020325115026.1FCAD24DB5@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> All architectures should support unaligned accesses.

Perhaps all architectures "should", but I can assure
you that many of them do no such thing. I didn't
look at every current architecture, but some notable
ones like the brand new IA64, as well as some older
chips such as MIPS have some relatively complicated
code in get_unaligned(), which can be found in the
appropriate include/asm-<arch> directory in the
file unaligned.h. I suspect that at least some of
these allow for an exception handler to fake the
capability in user space programs, but that isn't
something you can allow inside the kernel.

	Brad Boyer
	flar@allandria.com

