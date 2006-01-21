Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWAUSpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWAUSpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 13:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWAUSpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 13:45:09 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:16251 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932233AbWAUSpH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 13:45:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tKOK3Ocr43wRbD0apkQlkXLBkLK6tlFboIjRSgehBHUA7uq+p2cjL5GjRWJ7u4bYBPgrFwa25LDuweX7e/DXC29w3+vvja0v4/W4NcvvpWiMD4QkvjGo1tZ8puZ/9T9HVRXg1M9o1U2ti4x5nsSVwyhDNvU68zVfM3IMz8rZEi0=
Message-ID: <986ed62e0601211045p4a61a7c2v91d401af86f50d6@mail.gmail.com>
Date: Sat, 21 Jan 2006 10:45:06 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Ed Tomlinson <edt@aei.ca>
Subject: Re: 2.6.16-rc1-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, jgarzik@pobox.com, linux-scsi@vger.kernel.org
In-Reply-To: <200601211139.29019.edt@aei.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060120031555.7b6d65b7.akpm@osdl.org> <43D170CB.8080802@reub.net>
	 <200601211014.44041.edt@aei.ca> <200601211139.29019.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/06, Ed Tomlinson <edt@aei.ca> wrote:
> grover:/var/log# smartctl -i -d ata /dev/sda
[snip]
> grover:/var/log# smartctl -H -d ata /dev/sda
> smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
>
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
>
> ---
>
> Hope this helps and that I found the correct places to copy the info.

How about:
smartctl -a -d ata /dev/sda
or, if that produces too much output, then at least the following two:
smartctl -A -d ata /dev/sda
smartctl -l error -d ata /dev/sda

That way we might be able to figure out whether the disk
coincidentally started going bad after you updated the kernel.
--
-Barry K. Nathan <barryn@pobox.com>
