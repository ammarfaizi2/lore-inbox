Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSBRVtO>; Mon, 18 Feb 2002 16:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287933AbSBRVtE>; Mon, 18 Feb 2002 16:49:04 -0500
Received: from relay1.pair.com ([209.68.1.20]:3342 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S287895AbSBRVsy>;
	Mon, 18 Feb 2002 16:48:54 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C717894.281D0BB4@kegel.com>
Date: Mon, 18 Feb 2002 13:56:36 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Nick Craig-Wood <ncw@axis.demon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: time goes backwards periodically on laptop if booted in low-power 
 mode
In-Reply-To: <E16cvgK-0006uq-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > This isn't fixing the root cause of the problem which is interactions
> > between the BIOS power management and the kernel I believe, but it
> > does fix the problem and is really quite cheap so perhaps might be
> 
> do_gettimeofday is still going to give strange results - and consider
> the case where you boot slow and speed up...
> 
> If you can give me the DMI strings for the affected boxes I can add
> them to the DMi tables (see ftp://ftp.linux.org.uk/pub/linux/alan/DMI*)

ftp://ftp.linux.org.uk/pub/linux/alan/DMI/dmidecode.c works properly
on my desktop machine, but on the affected laptop it just repeatedly
prints out

DMI 2.3 present.
44 structures occupying 1330 bytes.
DMI table at 0x17FF0000.
dmi: read: Illegal seek

and doesn't say anything interesting.  Both machines are running
vanilla Red Hat 7.2, I think.  Shall I try it with vanilla 2.4.18-rc1?

- Dan
