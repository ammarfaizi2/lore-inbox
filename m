Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292194AbSBOV5B>; Fri, 15 Feb 2002 16:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292187AbSBOV4v>; Fri, 15 Feb 2002 16:56:51 -0500
Received: from are.twiddle.net ([64.81.246.98]:9354 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S292194AbSBOV4b>;
	Fri, 15 Feb 2002 16:56:31 -0500
Date: Fri, 15 Feb 2002 13:56:22 -0800
From: Richard Henderson <rth@twiddle.net>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Roman Zippel <zippel@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, davidm@hpl.hp.com,
        "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move task_struct allocation to arch
Message-ID: <20020215135622.B25047@twiddle.net>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, davidm@hpl.hp.com,
	"David S. Miller" <davem@redhat.com>, anton@samba.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <zippel@linux-m68k.org> <23760.1013782075@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <23760.1013782075@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Fri, Feb 15, 2002 at 02:07:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 02:07:55PM +0000, David Howells wrote:
> Should I move the convenience bit operations back to the arch header, so that
> the M68K guys can have byte-sized flags (which they can use TAS/TST on)?

If you provide some way to override the convenience bit operations,
then I suspect that you can let most folks use the byte ops.  It's
only older alphas that would absolutely have to play games.

Of course, I now have 9 flag bits defined, so I might not go back
to bytes anyway...


r~
