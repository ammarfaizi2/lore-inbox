Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWFZBLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWFZBLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWFZA6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14479 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964972AbWFZA6S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:18 -0400
Date: Sun, 25 Jun 2006 17:57:57 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: torvalds@osdl.org
Subject: [klibc 00/43] klibc as a historyless patchset
Message-Id: <klibc.200606251757.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As some people have requested, here is klibc as a historyless patchset
against 2.6.17.  The patchset consists of two parts: changes to the
main kernel code taken straight from the git history (as it is rather
few patches), and additions, grouped by rough divisions.

The majority of the patches are independent in the sense that they
should apply independently, but Makefile/Kbuild files may have to be
adjusted to build a partially patched tree.

This is also available as a git tree at:
git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc-clean.git

The full history klibc git tree is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

The files from the patchset are also available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/

This patchset corresponds to version 1.4.6 of the standalone klibc
distribution.

The following represent changes to the main kernel code:

01-add-klibckinit-to-maintainers-file.patch
02-remove-root-mounting-code-from-the-kernel-.patch
03-remove-parts-moved-to-kinit.patch
04-support-klibcarch-being-different-from-the-main-arch.patch
05-need-to-export-ranlib-from-the-top-makefile.patch
06-re-create-root-dev-too-many-architectures-need-it-.patch
07-eliminate-unnecessary-whitespace-delta-vs-linus-tree.patch
08-klibc-default-initramfs-content-stored-in-usrinitramfs-default.patch
09-kbuild-support-single-targets-for-klibc-and-klibc-programs.patch
10-remove-prototype-for-name-to-dev-t.patch
11-enable-klibc-errlist.patch
12-enable-config-klibc-zlib-now-required-to-build-kinit.patch
13-uml-the-klibc-architecture-is-the-underlying-architecture.patch
14-remove-in-kernel-nfsroot-code.patch
15-default-klibcarch--arch.patch
16-sparc64-transmit-arch-specific-options-to-kinit-via-arch-cmd.patch
17-sparc32-transfer-arch-specific-options-to-arch-cmd.patch
18-klibc-inkernel-merge-s390s390x-4.patch

The following represent klibc itself:

19-klibc-basic-build-infrastructure.patch
20-core-klibc-code.patch
21-alpha-support-for-klibc.patch
22-arm-support-for-klibc.patch
23-cris-support-for-klibc.patch
24-i386-support-for-klibc.patch
25-ia64-support-for-klibc.patch
26-m32r-support-for-klibc.patch
27-m68k-support-for-klibc.patch
28-mips-support-for-klibc.patch
29-mips64-support-for-klibc.patch
30-parisc-support-for-klibc.patch
31-ppc-support-for-klibc.patch
32-ppc64-support-for-klibc.patch
33-s390-support-for-klibc.patch
34-sh-support-for-klibc.patch
35-sparc-support-for-klibc.patch
36-sparc64-support-for-klibc.patch
37-x86-64-support-for-klibc.patch
38-simple-test-suite-for-klibc.patch
39-zlib-for-klibc.patch

This is kinit, which actually replaces the in-kernel root-mounting
code:

40-kinit-replacement-for-in-kernel-do-mount-ipconfig-nfsroot.patch

The following are optional utilites, for the convenience of people who
want to create their own custom initramfs, as well as for testing:

41-miscellaneous-utilities-for-klibc.patch
42-dash---a-small-posix-shell-for-klibc.patch
43-a-port-of-gzip-to-klibc.patch

