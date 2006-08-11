Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWHKRne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWHKRne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 13:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWHKRnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 13:43:33 -0400
Received: from mail.aknet.ru ([82.179.72.26]:37125 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932366AbWHKRnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 13:43:33 -0400
Message-ID: <44DCC283.7030709@aknet.ru>
Date: Fri, 11 Aug 2006 21:46:43 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jan Beulich <jbeulich@novell.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
References: <200608100101_MC3-1-C796-F8CA@compuserve.com> <44DB0927.76E4.0078.0@novell.com>
In-Reply-To: <44DB0927.76E4.0078.0@novell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Jan Beulich wrote:
> even more, as I'm now looking at it, this code seems
> outright wrong in using iret since that unmasks NMIs - Stas, is
> your pending adjustment to the 16-bit stack handling going to
> overcome this?)
No, it leaves the NMI path almost untouched.
But what exactly problem do you see with this iret?
If it unmasks NMI, then it does so for reason, which
is a return from an NMI handler. What exactly is wrong
with it?

