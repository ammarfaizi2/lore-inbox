Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVAWHro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVAWHro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVAWHro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:47:44 -0500
Received: from siaag1af.compuserve.com ([149.174.40.8]:41363 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S261248AbVAWHrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:47:40 -0500
Date: Sun, 23 Jan 2005 02:44:52 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 1/12] random pt4: Create new rol32/ror32 bitops
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Message-ID: <200501230247_MC3-1-93FA-7A4E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2005 at 20:13:24 -0800 Matt Mackall wrote:

> So I think tweaks for x86 at least are unnecessary. 

 So the compiler looks for that specific sequence of instructions:

        (a << b) | (a >> (sizeof(a) * 8 - b)

and recognizes that it means rotation?  Wow.


Chuck
