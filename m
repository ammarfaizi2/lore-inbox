Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUF2U0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUF2U0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUF2U0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:26:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:50358 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266004AbUF2U0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:26:40 -0400
Date: Tue, 29 Jun 2004 15:26:37 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: Janitor signature of rtas_call() routine
Message-ID: <20040629152637.M21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul, 

Can you please apply the following patch to the ameslab ppc64
tree, and/or roll it upwards to the marclello 2.6 tree?  
This path is 100% pure cleanup; no functional changes.

I got irritated when I was given a -1 that was cast to an unsigned
int that was then cast to a signed (64-bit) long, and so I received 
a value of 4 billion instead of -1.  This patch fixes this insanity.

Different files were treating this return code as being signed 
or unsigned, 32-bit or 64-bit.  The 'real' return code is always 
a signed 32-bit quantity, so this patch just makes the usage 
consistent across the board.

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas


