Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbTIKUat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbTIKUat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:30:49 -0400
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:29708
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S261516AbTIKU3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:29:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Large-file corruption. ReiserFS? VFS?
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 11 Sep 2003 16:28:58 -0400
Message-ID: <87r82noyr9.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran mkisofs (2.01a16) this morning on a 2.6.0-test4 machine with the
target on a 60GB ReiserFS partition.  The resulting file was to be
just over 4GB (around 4,360,000,000 bytes), and during most of the
course of writing the file, a small prefix looked as it should through
a hexdump: that is, just part of the iso9660 directory.
 
However, just as the write completed, the beginning of the file became
corrupted.  I considered a 4GB problem to be likely, and re-tested
with fewer source files such that the result would be smaller than
4GB; lo and behold, no corruption.  The same result occurs whether
mkisofs is given the -o flag, or output is redirected to a file from
stdout using the shell's redirection facility, suggesting the problem
is probably at the kernel level.
 
I don't have a large enough ext2/3 filesystem to compare with, so
there's no easy way for me to tell whether this is a Reiser-only
problem or not.  Can anyone confirm that they see the same problem, or
whether they see a similar problem on another file system?  Please
feel free to ask me for any other information you think might be
illuminating.

Cheers, 
Kyle 
