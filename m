Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265432AbVBFF6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265432AbVBFF6w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264856AbVBFF6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:58:52 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:12240 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268530AbVBFF6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:58:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=j6T3NcQ1NLNXtm39b+g1XTmcW/TXr1XQzBZ76DWlh10ItOIbHCrAeD2Fo9LuwSHihyKv02b5FBHuPGiTRVBCTQLUcdlaYWP3mBLGPoDlpf4vKLHB7qsOuztfbQxTvC09cNohhe7BKUaR4BWGqg87r9w0x6XWUmE3sM5SN4IpZzw=
Message-ID: <9e4733910502052158491b5ce3@mail.gmail.com>
Date: Sun, 6 Feb 2005 00:58:46 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Jones <davej@redhat.com>, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Intel AGP support attaching to wrong PCI IDs
In-Reply-To: <20050206040526.GA2908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910502051745c25d6f@mail.gmail.com>
	 <20050206040526.GA2908@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005 23:05:26 -0500, Dave Jones <davej@redhat.com> wrote:
> Take a peek at 'lspci -vv' output. You'll notice that the AGP
> capabilities are attached to the host bridge.

I see that now, why is it on the host bridge instead of the AGP
bridge? So that means if we add drivers for the host bridges we have
to add the code to the AGP drivers. It also implies that we have to
load them.

-- 
Jon Smirl
jonsmirl@gmail.com
