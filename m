Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVBNFvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVBNFvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 00:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVBNFvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 00:51:38 -0500
Received: from almesberger.net ([63.105.73.238]:64518 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261345AbVBNFvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 00:51:36 -0500
Date: Mon, 14 Feb 2005 02:49:16 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>,
       "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>,
       Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
Message-ID: <20050214024916.B1257@almesberger.net>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de> <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro> <20050121071144.GB657@wotan.suse.de> <20050207035707.C25338@almesberger.net> <m1hdkhzxxj.fsf@ebiederm.dsl.xmission.com> <20050212115106.A1257@almesberger.net> <m1brapzu1s.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1brapzu1s.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Sat, Feb 12, 2005 at 08:17:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> For detecting devices especially in the case that takes
> a while that isn't something we need to do early
> in the boot process.

Yes, but I'd rather have a generic mechanism that works in all
reasonable cases. Things have a tendency of growing in the oddest
directions. E.g. when introducing the boot command line, all I
had in mind was to have a way to boot single-user mode :-)

> Well the data structure is still yet to be defined.  The
> question you raised is how to pass it.

Err yes, that's what I wanted to say :) Some new mechanism to
pass the data, or a weird data structure instead of (as opposed
to be on) initrd/initramfs.

> Something like that.    I have yet to see a even a proof of concept
> of the idea of passing device information, to clean up probes.

Yes, the kexec-based boot loader first, then this. For a
kexec-based boot loader, passing device scan results will be
very useful, plus it's a good environment for experimenting
with such a feature.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
