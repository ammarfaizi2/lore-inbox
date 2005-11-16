Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbVKPWEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbVKPWEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbVKPWEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:04:13 -0500
Received: from web34102.mail.mud.yahoo.com ([66.163.178.100]:44456 "HELO
	web34102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030476AbVKPWEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:04:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SimfUxYBcdwnrKvug6Tqnw4Y+SZ/ve0/9qDa5yFARj1CrpAo5LP7yVzpHeIqUJdfBNe3MJHF7EbTMRjBKmKpHd1G3gxnnaHatJvCFHQ8djZ25TkU9jaeUxpUZNI4xqlhYEaRw9TWajysxoGM4y1DORk0x82vJQGCD4oulUzLX9Y=  ;
Message-ID: <20051116220406.25675.qmail@web34102.mail.mud.yahoo.com>
Date: Wed, 16 Nov 2005 14:04:06 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1132178234.8811.64.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> I'm getting lost here. Please could you spell out the testcases that are
> not working.
> 
> Are you saying that the combination mmap() + pwrite64() fails on
> O_DIRECT, but works on ordinary open, and that mmap() + ftruncate64()
> always works?
> 
> Cheers,
>   Trond
> 
ftruncate64 works with O_DIRECT
ftruncate64 works w/o O_DIRECT

pwrite64 FAILS with O_DIRECT at ~4GB
pwrite64 works w/o O_DIRECT.

I am re-running these tests to confirm (could take a minute).

All opens are with O_RDWR | O_CREAT | O_LARGEFILE.
All test over GbE w/ jumbo frames (8160 mtu) to a netapp filer (via x-over cable).

-Kenny



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
