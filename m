Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbQKQTyx>; Fri, 17 Nov 2000 14:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbQKQTyq>; Fri, 17 Nov 2000 14:54:46 -0500
Received: from wirex.com ([208.161.110.91]:7185 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S129983AbQKQTye>;
	Fri, 17 Nov 2000 14:54:34 -0500
Date: Fri, 17 Nov 2000 11:23:36 -0800
From: jesse <jesse@wirex.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001117112336.A8854@wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116150704.A883@emma1.emma.line.org> <20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com> <20001117003000.B2918@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001117003000.B2918@wire.cadcamlab.org>; from peter@cadcamlab.org on Fri, Nov 17, 2000 at 12:30:00AM -0600
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 12:30:00AM -0600, Peter Samuelson wrote:
> Two easy "get out of jail free" cards.  There are other, more complex
> exploits.  You have added one more.  They all require root privileges.

Actually, I've heard that a chrooted _non-root_ process can find another
process with the same uid that's not chrooted and can ptrace() to pull
itself out of the jail.

I'd imagine dropping CAP_SYS_PTRACE would avoid this, though.
 
> Bottom line: once you are in the chroot jail, you must drop root
> privileges, or you defeat the purpose.  Security-conscious coders know
> this; it's not Linux-specific behavior or anything.

It appears that even dropping root privileges might not be enough.

And I realize that there are a number of ways that a root process can
escape, I was mostly objecting to the assertion that chroot() was secure
because everything before the chroot call is assumed to be trusted.

-Jesse
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
