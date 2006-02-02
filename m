Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423392AbWBBI6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423392AbWBBI6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423391AbWBBI6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:58:24 -0500
Received: from ns1.suse.de ([195.135.220.2]:23429 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423390AbWBBI6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:58:24 -0500
Message-ID: <43E1C9A7.7000408@suse.de>
Date: Thu, 02 Feb 2006 09:58:15 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1-mm4
References: <20901.1138838191@ocs3.ocs.com.au>
In-Reply-To: <20901.1138838191@ocs3.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Chuck Ebbert (on Tue, 31 Jan 2006 21:44:20 -0500) wrote:
>> Error: ./arch/i386/kernel/alternative.o .smp_locks refers to 00000008 R_386_32          .init.text

> Looking at the patch, it builds tables that can refer to .init.text but
> then it excludes table entries that do not fall between _text and
> _etext.

Yep.  The same goes for modules where the patch also keeps track of the
.text section ranges to avoid accessing __init regions which might have
been released meanwhile.

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
