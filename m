Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261833AbSIXVT5>; Tue, 24 Sep 2002 17:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbSIXVT5>; Tue, 24 Sep 2002 17:19:57 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:6408
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261833AbSIXVT4>; Tue, 24 Sep 2002 17:19:56 -0400
Subject: Re: Interrupt Sharing
From: Robert Love <rml@tech9.net>
To: Mohamed "Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB53050A4C9C@mail2.ggn.hcltech.com>
References: <5F0021EEA434D511BE7300D0B7B6AB53050A4C9C@mail2.ggn.hcltech.com>
Content-Type: text/plain
Organization: 
Message-Id: <1032902702.1019.103.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 24 Sep 2002 17:25:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-24 at 17:19, Mohamed Ghouse , Gurgaon wrote:

> Let me Re-Phrase the Question
> The PCI Interrupts are shareable. How does the Operating System(Linux)
> implement this?

It does not have to do anything special, actually.  If interrupt n comes
in, then each handler registered on interrupt n is run.

The incorrect handlers should check for work to do, see none, and
return.  The correct one will actually run.

	Robert Love

