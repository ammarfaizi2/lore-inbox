Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262606AbRFCAXw>; Sat, 2 Jun 2001 20:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbRFCAXm>; Sat, 2 Jun 2001 20:23:42 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:3373 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262606AbRFCAX2>; Sat, 2 Jun 2001 20:23:28 -0400
Subject: Re: symlink_prefix
From: Robert Love <rml@tech9.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <UTC200106022354.BAA182685.aeb@vlet.cwi.nl>
In-Reply-To: <UTC200106022354.BAA182685.aeb@vlet.cwi.nl>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 02 Jun 2001 20:23:25 -0400
Message-Id: <991527807.771.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Jun 2001 01:54:43 +0200, Andries.Brouwer@cwi.nl wrote:
> This evening I needed to work on a filesystem of a non-Linux OS,
> full of absolute symlinks. After mounting the fs on /mnt, each
> symlink pointing to /foo/bar in that filesystem should be
> regarded as pointing to /mnt/foo/bar.
> 
> Since doing ls -ld on every component of every pathname was
> far too slow, I made a small kernel wart, where a mount option
> -o symlink_prefix=/pathname would cause /pathname to be prepended
> in front of every absolute symlink in the given filesystem
> (when the symlink is followed). That works satisfactorily.<snip>

unfortunately i cant speak for whether or not this patch is
reengineering the work of altroot (i have no experience with it) or
whether there are other similar approaches.

what i can say is that this is an excellent idea -- i have often cursed
having absolute symlinsk v. relative ones and this option would provide
a wonderful fix to that.

plus, i bet this is a rather simple and clean option.

i would like to see this in the kernel if it does not tread on any other
similar feature.

> (i) is there already a mechanism that would achieve this?
cant answer

> (ii) if not, do we want something like this in the kernel?
for sure.


-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

