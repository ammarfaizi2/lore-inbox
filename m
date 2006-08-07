Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWHGILg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWHGILg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWHGILg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:11:36 -0400
Received: from ns1.suse.de ([195.135.220.2]:4800 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751152AbWHGILg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:11:36 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch] i386: fix stuck unwind into kernel thread
Date: Mon, 7 Aug 2006 10:11:31 +0200
User-Agent: KMail/1.9.3
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
References: <200608061458_MC3-1-C742-330A@compuserve.com> <44D710D9.76E4.0078.0@novell.com>
In-Reply-To: <44D710D9.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071011.31473.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 10:07, Jan Beulich wrote:
> >>> Chuck Ebbert <76306.1226@compuserve.com> 06.08.06 20:56 >>>
> >We cannot unwind past kernel_thread_helper.
> 
> Just as mentioned before - we shouldn't add endless special cases to the code that interprets the unwind
> information, but rather fix the unwind information so that it properly reflect the actual state. Like in the
> other case, the piece of code should be properly annotated, which would require it to be moved into
> an assembly file (it escapes me why code like that was ever placed in a C file).

I can do that.

-Andi
