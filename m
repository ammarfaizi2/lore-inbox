Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTJCIyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTJCIyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:54:24 -0400
Received: from 218-bem-2.acn.waw.pl ([62.121.81.218]:55569 "EHLO
	woland.michal.waw.pl") by vger.kernel.org with ESMTP
	id S263637AbTJCIyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:54:07 -0400
Date: Fri, 3 Oct 2003 10:54:12 +0200
From: Michal Kochanowicz <michal@michal.waw.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test6] definition and usage of __u64/__s64 inconsistent?
Message-ID: <20031003085412.GA4602@wieszak.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Organization: Happy GNU/Linux Users
X-Signature-Tagline-Copyright: Piotr Zientarski, 1999-2001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The two types are _conditionally_ defined as follows (in asm/types.h):
#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
typedef __signed__ long long __s64;
typedef unsigned long long __u64;
#endif

The file asm/types.h is _unconditionally_ included from linux/cdrom.h
and linux/loop.h and both files use __u64 unonditionally. Isn't this an
error?

Regards

PS. I came across this problem while trying to compile
kdemultimedia-3.1.4 which uses linux/linux.h - if it does matter.
-- 
--= Michal Kochanowicz =--==--==BOFH==--==--= michal@michal.waw.pl =--
--= finger me for PGP public key or visit http://michal.waw.pl/PGP =--
--==--==--==--==--==-- Vodka. Connecting people.--==--==--==--==--==--
A chodzenie po górach SSIE!!!
