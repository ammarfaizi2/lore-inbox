Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSJKAlh>; Thu, 10 Oct 2002 20:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262234AbSJKAlh>; Thu, 10 Oct 2002 20:41:37 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21908 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262224AbSJKAlh>;
	Thu, 10 Oct 2002 20:41:37 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Oct 2002 02:47:22 +0200 (MEST)
Message-Id: <UTC200210110047.g9B0lMI07774.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: tcp urgent data broken since 2.5.34?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.5.34 I see a lot of processes hanging for a while.
I just looked at what might cause this, and I get the strong
impression that something went wrong with the 2.5.34 patch
that introduced sk_send_sigurg() (or possibly the signal
handling).

Phenomenon:
 B->A: urg 1
 B->A: some data
 A->B: ack for the urg
half a minute later:
 B->A: resend of some data
 A->B: ack

This is using rlogin/rlogind.
Will look further later, but in the meantime somebody might
see immediately what causes this.

Andries

