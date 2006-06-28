Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423154AbWF1FSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423154AbWF1FSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423156AbWF1FSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:18:31 -0400
Received: from terminus.zytor.com ([192.83.249.54]:38121 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423152AbWF1FSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:11 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com,
       Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 00/31] klibc as a historyless patchset (updated and reorganized)
Date: Tue, 27 Jun 2006 22:17:00 -0700
Message-Id: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated the klibc patchset based on feedback received.  In
particular, the patchset has been reorganized so as not to break
git-bisect.

Additionally, this updates the patch base to 2.6.17-git12
(d38b69689c349f35502b92e20dafb30c62d49d63) and klibc 1.4.8; the main
difference on the klibc side is removal of obsolete code.

This is also available as a git tree at:
git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc-clean.git

The full history klibc git tree is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

The files from the patchset are also available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/

This patchset corresponds to version 1.4.8 of the standalone klibc
distribution.

Initial infrastructure:

01-add-klibckinit-to-maintainers-file.patch
02-main-makefile-changes-for-klibc.patch

Klibc proper (only added as inert files at this point):

03-core-klibc-code.patch
04-alpha-support-for-klibc.patch
05-arm-support-for-klibc.patch
06-cris-support-for-klibc.patch
07-i386-support-for-klibc.patch
08-ia64-support-for-klibc.patch
09-m32r-support-for-klibc.patch
10-m68k-support-for-klibc.patch
11-mips-support-for-klibc.patch
12-mips64-support-for-klibc.patch
13-parisc-support-for-klibc.patch
14-ppc-support-for-klibc.patch
15-ppc64-support-for-klibc.patch
16-s390-support-for-klibc.patch
17-sh-support-for-klibc.patch
18-sparc-support-for-klibc.patch
19-sparc64-support-for-klibc.patch
20-x86-64-support-for-klibc.patch
21-simple-test-suite-for-klibc.patch
22-zlib-for-klibc.patch

Kinit:

23-kinit-replacement-for-in-kernel-do-mount-ipconfig-nfsroot.patch

Kbuild support for klibc (this activates the klibc/kinit build):

24-klibc-basic-build-infrastructure.patch

Optional utilities (it should be possible to omit without breakage):

25-miscellaneous-utilities-for-klibc.patch
26-dash---a-small-posix-shell-for-klibc.patch
27-a-port-of-gzip-to-klibc.patch

SPARC-specific support (export variables from openprom):

28-sparc64-transmit-arch-specific-options-to-kinit-via-arch-cmd.patch
29-sparc32-transfer-arch-specific-options-to-arch-cmd.patch

Removal of kernel resume from disk and root-mounting code:

30-remove-in-kernel-resume-from-disk-invocation-code.patch
31-remove-in-kernel-root-mounting-code.patch
