Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWH1P0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWH1P0e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 11:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWH1P0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 11:26:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:14857 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751073AbWH1P0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 11:26:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pJa1xzyJ7rgiajxhq0/4skmlmi+/+glpGFwzzak+DJAAv60yqwKLmDFR+lCKQKmrhukcJs3qv0+xWamPn76syDR3rX8DrFgd6dH1VHgW8NlT0Eqtf1U3tD3D8OmMif0XvtlcpQJI87Jf6C0rd/IXh7jUtqzyk3TQTSd0Cg2FlTY=
Message-ID: <d120d5000608280826i6542aaeeoba5afe1345615eac@mail.gmail.com>
Date: Mon, 28 Aug 2006 11:26:30 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Linux v2.6.18-rc5
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	 <20060827231421.f0fc9db1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, Andrew Morton <akpm@osdl.org> wrote:
>
> From: "Uwe Bugla" <uwe.bugla@gmx.de>
> Subject: keyboard errors with module atkbd.c in Kernel 2.6.18-rc4
>

There were 2 issues in that report. One is that we do not emit keyup
events when unregistering an input device which causes enter key
appear "stuck" after removing atkbd module. I have a patch for this
but it is hardly a critical issue.

The second issue is that he is losing keyboard input (along with the
network) but only in KDE while using video-editing program for some
hours. Unfortunately userspace was updated along with the kernel and I
did not get a clear answer whether simply erolling back to 2.6.17
without changing anything else cures the issue or not.

>
> From: "Zephaniah E. Hull" <warp@aehallh.com>
> Subject: [patch] Crash on evdev disconnect.
>

While it is a problem it is not a regression ;P

-- 
Dmitry
