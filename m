Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSK0XMg>; Wed, 27 Nov 2002 18:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbSK0XMg>; Wed, 27 Nov 2002 18:12:36 -0500
Received: from fmr01.intel.com ([192.55.52.18]:20189 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264925AbSK0XMf>;
	Wed, 27 Nov 2002 18:12:35 -0500
Message-ID: <007401c2966b$7e370fc0$94d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Rusty Russell" <rusty@rustcorp.com.au>,
       "Wang, Stanley" <stanley.wang@intel.com>
Cc: <linux-kernel@vger.kernel.org>
References: <20021127225227.746B12C0BD@lists.samba.org>
Subject: Re: [BUG] [2.5.49] symbol_get doesn't work 
Date: Wed, 27 Nov 2002 15:19:53 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> Hi Wang,
> 
> Thanks for the bug report, but I think you misunderstand.
> symbol_get() does not take a string, it takes an identifier.  This
> way, we can ensure the type is correct.  eg.
> 
> /* In header somewhere. */
> extern int their_integer;
> 
> ....
> int *ptr = symbol_get(their_integer);
> if (!ptr) ...
> 

I couldn't find a single file in the kernel that uses this.  What
would be the appropriate scenario for using this?  Is there
code in the kernel that is suppose to migrating to this?

    -rustyl 

