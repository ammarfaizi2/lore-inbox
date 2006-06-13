Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbWFMAgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWFMAgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWFMAgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:36:17 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:20413 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932690AbWFMAgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:36:12 -0400
Date: Mon, 12 Jun 2006 20:31:35 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: PROBLEM: 2.6.16.20 kernel oops
To: Petr Sebor <petr@scssoft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606122034_MC3-1-C243-3BA4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <448DE077.1040900@scssoft.com>

On Mon, 12 Jun 2006 23:45:27 +0200, Petr Sebor wrote:

> Jun 12 18:53:42 server kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
> Jun 12 18:53:42 server kernel:  printing eip:
> Jun 12 18:53:42 server kernel: c0237744
> Jun 12 18:53:42 server kernel: *pde = 00000000
> Jun 12 18:53:42 server kernel: Oops: 0002 [#1]

Looks like your hardware is failing.

Disassembly shows:

Code;  c0237744 No symbols available   <=====
   0:   ba 08 00 00 00            mov    $0x8,%edx   <=====

...and there is no way this instruction can cause that fault.

Your previous bug looked flakey too.

Run memtest86 overnight to see if it finds anything.  Also
check the CPU temperature.

-- 
Chuck
