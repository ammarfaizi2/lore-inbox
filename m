Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278088AbRJVIG5>; Mon, 22 Oct 2001 04:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278080AbRJVIGI>; Mon, 22 Oct 2001 04:06:08 -0400
Received: from zok.sgi.com ([204.94.215.101]:12980 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278089AbRJVIFV>;
	Mon, 22 Oct 2001 04:05:21 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.12-ac5 
In-Reply-To: Your message of "Sun, 21 Oct 2001 23:41:10 CST."
             <20011021234110.A4193@zed.dlitz.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 18:05:46 +1000
Message-ID: <23534.1003737946@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2001 23:41:10 -0600, 
"Dwayne C. Litzenberger" <dlitz@dlitz.net> wrote:
>Alan, is this normal?
>
>zed:~# cat /proc/sys/kernel/tainted
>1
>zed:~# echo "0" >/proc/sys/kernel/tainted
>zed:~# cat /proc/sys/kernel/tainted
>0

I decided against adding special code to sysctl for the taint flag so
yes, you can clear it.  There is no point in adding special code for
the taint sysctl, it is even easier to remove the taint message from
the log before submitting.

As AC has said (several times) tainting is not foolproof, it is to help
triage bug reports from people who don't submit complete information.
Those users who know enough to lie are also unlikely to submit bug
reports.  Tainting is to help beginners.

