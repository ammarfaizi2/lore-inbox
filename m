Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWIMTRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWIMTRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWIMTRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:17:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29905 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751137AbWIMTRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:17:31 -0400
Subject: Re: Assignment of GDT entries
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
In-Reply-To: <450854F3.20603@goop.org>
References: <450854F3.20603@goop.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 13 Sep 2006 21:16:41 +0200
Message-Id: <1158175001.3054.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 11:58 -0700, Jeremy Fitzhardinge wrote:
> What's the rationale for the current assignment of GDT entries?  In 
> particular, this section:
> 
>  *   0 - null
>  *   1 - reserved
>  *   2 - reserved
>  *   3 - reserved
>  *
>  *   4 - unused			<==== new cacheline
>  *   5 - unused
>  *
>  *  ------- start of TLS (Thread-Local Storage) segments:
>  *
>  *   6 - TLS segment #1			[ glibc's TLS segment ]
>  *   7 - TLS segment #2			[ Wine's %fs Win32 segment ]
>  *   8 - TLS segment #3
>  *   9 - reserved
>  *  10 - reserved
>  *  11 - reserved
> 
> 
> What are entries 1-3 and 9-11 reserved for?  Must they be unused for 
> some reason, or is there some proposed use that has not been impemented yet?


I don't know the exact details on these; I do know that several GDT
entries tend to be used by BIOSes in their APM implementations and thus
are better of not being used. That might be the underlying reason
here....


