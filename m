Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAPN7E>; Tue, 16 Jan 2001 08:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRAPN6y>; Tue, 16 Jan 2001 08:58:54 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:28179 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129383AbRAPN6n>; Tue, 16 Jan 2001 08:58:43 -0500
Date: Tue, 16 Jan 2001 14:57:05 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: 'native files', 'object fingerprints' [was: sendpath()]
Message-ID: <20010116145705.C19949@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.10.10101152056170.12667-100000@penguin.transmeta.com> <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101161020200.673-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 10:48:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 	struct native_file {
> 		unsigned long master_fingerprint[8];
> 		unsigned long file_fingerprint[8];
> 		struct file file;
> 	};
> 
> 'fingerprints' are 256 bit, true random numbers. master_fingerprint is
> global to the kernel and is generated once per boot. It validates the
> pointer of the structure. The master fingerprint is never known to
> user-space.
> 
> file_fingerprint is a 256-bit identifier generated for this native file.
> The file fingerprint and the (kernel) pointer to the native file is
> returned to user-space. The cryptographical safety of these 256-bit random
> numbers guarantees that no breach can occur in a reasonable period of
> time. It's in essence an 'encrypted' communication between kernel and
> user-space.

Sounds similar to the Hurd...

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
