Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTEBIkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTEBIkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:40:22 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:54945 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261956AbTEBIkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:40:22 -0400
Date: Fri, 2 May 2003 04:50:45 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305020452_MC3-1-3708-DBEE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> I know you think GCC is a pile of dogshit, in many ways I do too, but I
> think it's just as important to point out the good parts where they
> exist.

  GCC is the strangest combination of utterly brilliant and brain-dead
stupid that I've ever seen... I've seen it do tail merges that took
my breath away, followed by this:

  mov <mem1>,eax
  mov eax,<mem2>
  mov <mem1>,eax        ; eax already contains mem1 you stupid compiler
  ret

------
 Chuck
