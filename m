Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUDFMCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbUDFMCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:02:39 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:53647 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263771AbUDFMCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:02:37 -0400
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: Catching SIGSEGV with signal() in 2.6
Date: Tue, 6 Apr 2004 08:02:29 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200404052040.54301.kevin.hendricks@sympatico.ca> <200404052301.28021.kevin.hendricks@sympatico.ca> <40722D42.90406@redhat.com>
In-Reply-To: <40722D42.90406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404060802.29409.kevin.hendricks@sympatico.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulrich,

> The old code depended on undefined behavior.

Thanks for explanation.  It makes perfect sense.  I appreciate it.

Our bad assumption was that using signal to install a signalhandler on a 
specific signal unblocked that specific signal, but as you show it does not.

I will try to get a fix using sigsetjmp/siglongjmp or fork/wait into the 
forthcoming OOo 1.1.2 tree so that no more "problems" are reported.

Kevin


