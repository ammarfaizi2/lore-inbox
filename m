Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318930AbSHEXtQ>; Mon, 5 Aug 2002 19:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318940AbSHEXtQ>; Mon, 5 Aug 2002 19:49:16 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:40964 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318930AbSHEXtP>;
	Mon, 5 Aug 2002 19:49:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: lkml <linux-kernel@vger.kernel.org>
Subject: FAQ: Why does make modules_install flag all symbols as missing?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Aug 2002 09:51:15 +1000
Message-ID: <7867.1028591475@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This FAQ should be a short term one, not worth adding to lkml faq.

Q.  Why does make modules_install flag all symbols as missing?
    
    make modules_install
    ...
    depmod -ae -F /boot/System.map-2.4.19 2.4.19

    All symbols are reported as missing.

A.  binutils 2.12.90.0.15 changed the format of the output from the nm
    command and broke modutils.  You need modutils >= 2.4.17 if you are
    running binutils >= 2.12.90.0.15.

For the curious, the symbol type for kstrtab and ksymtab in System.map
has been '?' since modules were added.  binutils 2.12.90.0.15 changed
the symbol type to 'R'.

