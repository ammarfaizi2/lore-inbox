Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270227AbSISHLw>; Thu, 19 Sep 2002 03:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270263AbSISHLw>; Thu, 19 Sep 2002 03:11:52 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:29173 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S270227AbSISHLw>; Thu, 19 Sep 2002 03:11:52 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <024501c25f45$1db02360$9e10a8c0@IMRANPC> 
References: <024501c25f45$1db02360$9e10a8c0@IMRANPC> 
To: imran.badr@cavium.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: interruptible_sleep_on_timeout() and signals 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Sep 2002 08:16:52 +0100
Message-ID: <14338.1032419812@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


imran.badr@cavium.com said:
>  How would I figure out whether interruptible_sleep_on_timeout()
> returned on a timeout condition, someone called wakeup() or the user
> pressed CTRL-C i.e., interrupted by a signal? Is signal_pending()the
> right choice ?

Don't forget that there can also be any combination of two or all three of 
the above. Don't use sleep_on functions because they're almost impossible 
to use correctly.

--
dwmw2


