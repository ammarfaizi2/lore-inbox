Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTEVQKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbTEVQKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:10:06 -0400
Received: from hera.cwi.nl ([192.16.191.8]:25590 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262728AbTEVQKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:10:03 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 22 May 2003 18:22:49 +0200 (MEST)
Message-Id: <UTC200305221622.h4MGMnO01732.aeb@smtp.cwi.nl>
To: jsimmons@infradead.org, wli@holomorphy.com
Subject: Re: keyboard.c/kd.h field width fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: William Lee Irwin III <wli@holomorphy.com>

    These guys get massive numbers of warnings about comparisons always true
    or false due to limited ranges of data types. This appears to kill off
    the warnings.

    diff -prauN mm8-2.5.69-1/include/linux/kd.h mm8-2.5.69-2/include/linux/kd.h
    --- mm8-2.5.69-1/include/linux/kd.h    2003-05-04 16:53:37.000000000 -0700
    +++ mm8-2.5.69-2/include/linux/kd.h    2003-05-22 07:57:24.000000000 -0700
    @@ -95,8 +95,8 @@ struct unimapinit {
     #define    KDSKBLED    0x4B65    /* set led flags (not lights) */
     
     struct kbentry {
    -    unsigned char kb_table;
    -    unsigned char kb_index;
    +    unsigned short kb_table;
    +    unsigned short kb_index;
         unsigned short kb_value;
     };
     #define        K_NORMTAB    0x00


Unfortunately it also changes the ioctl interface.
This should not be applied.

Andries
