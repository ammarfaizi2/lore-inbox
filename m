Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSEHVb7>; Wed, 8 May 2002 17:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315284AbSEHVb6>; Wed, 8 May 2002 17:31:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37392 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315218AbSEHVbh>;
	Wed, 8 May 2002 17:31:37 -0400
Message-ID: <3CD998FC.9C21949C@zip.com.au>
Date: Wed, 08 May 2002 14:30:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading page from given block device
In-Reply-To: <20020508204809.GA2300@elf.ucw.cz> <3CD996E5.BFB5CF9E@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ..
> >         memcpy(buf, bh->b_data, PAGE_SIZE);
> 
> You'll need to kmap bh->b_page before copying the data.

No you won't.  blockdev mappings don't use highmem.

-
