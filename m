Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289030AbSAZFEE>; Sat, 26 Jan 2002 00:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289024AbSAZFDy>; Sat, 26 Jan 2002 00:03:54 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:64642 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289022AbSAZFDk>; Sat, 26 Jan 2002 00:03:40 -0500
Date: Sat, 26 Jan 2002 04:59:34 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alexander Viro <viro@math.psu.edu>, Dan Maas <dmaas@dcine.com>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Message-ID: <20020126045934.A6016@kushida.apsleyroad.org>
In-Reply-To: <20020126034559.G5730@kushida.apsleyroad.org> <Pine.GSO.4.21.0201252327001.27397-100000@weyl.math.psu.edu> <20020125233851.B10685@pimlott.ne.mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020125233851.B10685@pimlott.ne.mediaone.net>; from andrew@pimlott.ne.mediaone.net on Fri, Jan 25, 2002 at 11:38:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Pimlott wrote:
> > Most likely it says very bad things about getcwd() implementation in Perl
> > compared to sys_getcwd() in the kernel.
> 
> No no no--it says very bad things about 'use POSIX', and in general
> about overhead-creep in the perl library.

I ended up calling sys_getcwd from Perl as it's extremely fast.  Even
faster if you hard code the syscall number instead of reading the header
file in Perl :-)

However, I was still impressed by the 0.0075s for a pipe/fork/exec.

'use POSIX' is very slow, but Perl's getcwd() is pretty slow too -- it
does the old fashioned directory walk.  We cannot blame it for being
portable.

-- Jamie
