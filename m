Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbUKRXTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUKRXTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUKRXRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:17:55 -0500
Received: from siaag2ae.compuserve.com ([149.174.40.135]:9280 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S262997AbUKRXQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:16:20 -0500
Date: Thu, 18 Nov 2004 18:14:06 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Six archs are missing atomic_inc_return()
To: Anton Blanchard <anton@samba.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411181816_MC3-1-8EFB-D509@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton wrote:

> $ grep -l atomic_inc_return include/asm-*/atomic.h


  I was assuming all archs used a macro for this, so I used:

$ grep 'define atomic_inc_return' asm-*/atomic.h


  But your grep could have found this:

        /* FIXME: this arch does not have atomic_inc_return */

and returned a false positive.


  What I need is a C-aware grep:

$ cgrep [--definition | --comment | --usage] atomic_inc_return asm-*/atomic.h

to search definitions, comments, and code body respectively.


--Chuck Ebbert  18-Nov-04  18:08:49
