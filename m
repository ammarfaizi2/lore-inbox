Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWECHTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWECHTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 03:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWECHTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 03:19:32 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:43914 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965013AbWECHTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 03:19:31 -0400
Message-ID: <346640766.02031@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 3 May 2006 15:19:48 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060503071948.GD4781@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <20060502191000.GA1776@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502191000.GA1776@elf.ucw.cz>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 09:10:01PM +0200, Pavel Machek wrote:
> Could we use this instead of blockdev freezing/big suspend image
> support? It should permit us to resume quickly (with small image), and
> then do readahead. ... that will give us usable machine quickly, still
> very responsive desktop after resume?

Seems that it can help in reducing the image size:
write only small ranges of file pages to the suspend image(maybe 80MB
= 10k ranges * 8k avgsize), and let the prefetcher restore other large
chunks of code/data, depending on user specified policies.

Wu
