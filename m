Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUBRMbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266369AbUBRMbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:31:49 -0500
Received: from [212.28.208.94] ([212.28.208.94]:37135 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265201AbUBRMbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:31:47 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: tridge@samba.org
Subject: Re: UTF-8 and case-insensitivity
Date: Wed, 18 Feb 2004 13:31:36 +0100
User-Agent: KMail/1.6.1
Cc: hpa@zytor.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <16434.58656.381712.241116@samba.org> <200402181105.58425.robin.rosenberg.lists@dewire.com> <16435.20457.610841.62521@samba.org>
In-Reply-To: <16435.20457.610841.62521@samba.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402181331.36859.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 February 2004 12.43, tridge@samba.org wrote:
> Robin,
>  > I've read it also:
>  > http://www.microsoft.com/globaldev/getwr/steps/wrg_unicode.mspx
>  > "The fundamental representation of text in Windows NT-based
>  > operating systems is UTF-16"

I believe (please correct me if this is wrong) that Windows never actually
supported any of the UCS-2 code that were in conflict with UTF-16. The cost
of this operation was that some of the "private" code blocks of unicode 2.0, i.e. 
U+D800..U+DFFF were redefined as "surrogates" in Unicode 3.0 making the 
UTF-16 encoding more or less backwards compatible with UCS-2. And it's 
UTF-16LE and UCS-2LE, but I suspect you knew that :-)

> yep, in this thread I've been mistakenly using the term UCS-16 when I
> should have said UTF-16 (ie. the variable length, 2 byte encoding).
> 
> Samba currently treats the bytes on the wire from windows as UCS-2 (a
> 2 byte fixed width encoding), whereas perhaps it should be treating
> them as UTF-16. I should write a smbtorture test to detect the
> difference and see what different versions of windows actually use.
See above, and most importantly the definition in Amendment 1 of the unicode 
3.0 standard.

> luckily the new charset handling stuff in samba3 and samba4 will make
> this easy to fix :-)
Happy man!

-- robin
