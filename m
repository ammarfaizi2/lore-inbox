Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291197AbSBGSb6>; Thu, 7 Feb 2002 13:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291191AbSBGSae>; Thu, 7 Feb 2002 13:30:34 -0500
Received: from pc-62-31-66-114-ed.blueyonder.co.uk ([62.31.66.114]:36228 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S291195AbSBGS3c>; Thu, 7 Feb 2002 13:29:32 -0500
Date: Thu, 7 Feb 2002 18:29:25 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andres Salomon <dilinger@mp3revolution.net>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: D state processes in 2.4.18-pre7-ac3
Message-ID: <20020207182925.N2227@redhat.com>
In-Reply-To: <20020207090237.GA2137@mp3revolution.net> <3C624782.14FC8C70@zip.com.au> <20020207145356.GA4658@mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020207145356.GA4658@mp3revolution.net>; from dilinger@mp3revolution.net on Thu, Feb 07, 2002 at 09:53:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 07, 2002 at 09:53:56AM -0500, Andres Salomon wrote:
> No messages at all, actually.  I noticed my sysrq-t made it into my logs
> (although it doesn't look all too correct..), so I've included it
> below.  The D-state processes themselves seem to be the only indication of
> something gone wrong.  
 
>From this:

> Feb  7 02:30:01 incandescent kernel: bash          D C0079EB0     0 14718  27389          3494 27391 (NOTLB)
> Feb  7 02:30:01 incandescent kernel: Call Trace: [__wait_on_buffer+106/144] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-599850/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-608890/96] [do_page_fault+355/1172] [do_page_fault+0/1172] 
> Feb  7 02:30:01 incandescent kernel:    [vfs_readdir+97/144] [filldir64+0/368] [sys_getdents64+79/259] [filldir64+0/368] [sys_fcntl64+128/144] [system_call+51/56] 

it looks as if there are other processes stalled on IO too.
Unfortunately the modules decoding of the call traces looks broken, so
it's hard from this to really work out what might be the source of
that particular stall.

Is this at all reproducible?  Had you been running any LVM utils
recently?

--Stephen
