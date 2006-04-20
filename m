Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWDTWPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWDTWPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWDTWPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:15:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:43846 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932077AbWDTWPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:15:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=U2hVXGa2s+HJNM7GATfJP1uE1O/WdLXLA0Eyepo1FGPn5yArniElI3rUS8+uKxpE9s+wJG3C13hWhH27qqLhiQL//fhikRn0dTlGWaG1HHMudRa9mFwgVofVEA9OWwvAYSzAxchK/AIWFaPW/dvceBSBghmo53uwLfP6RKAFJKo=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Jan Engelhardt'" <jengelh@linux01.gwdg.de>,
       "'Mikado'" <mikado4vn@gmail.com>
Cc: "'linux-os \(Dick Johnson\)'" <linux-os@analogic.com>,
       "'Linux kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Which process is associated with process ID 0 (swapper)
Date: Thu, 20 Apr 2006 15:15:15 -0700
Message-ID: <004801c664c7$e80acfd0$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.61.0604210007140.28841@yvahk01.tjqt.qr>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZkx38VDc4mre6pRLOGgFhfNuX1UAAACsow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Linux really has swapper process ;)
> >
> To be precise, it has more than one.
> 
> When you hit an OOPS, the trace [1] might show:
> "Pid: 0, comm: swapper Not tainted 2.6.11.6"
> 
> Plus you see one of these per CPU [ps aufwwx]:
> root       106  0.0  0.0      0     0 ?        S    Apr20   
> 0:04 [kswapd0]
> 
> So, a question to the public: what swapper swaps, and what's 
> swapper(as in pid 0) in oops, if there's no PID 0?

Swapper is the idle process, which swaps nothing. Its name is historic and it doesn't appear in /proc because for_each_process()
skips it.

Kswapd is totally different.

