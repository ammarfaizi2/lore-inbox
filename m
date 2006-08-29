Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWH2I61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWH2I61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWH2I60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:58:26 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:24291 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750844AbWH2I60
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:58:26 -0400
Message-ID: <44F400EA.5020506@aitel.hist.no>
Date: Tue, 29 Aug 2006 10:55:06 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@dunaweb.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to determine whether a file was opened O_DIRECT?
References: <3557.213.163.11.81.1156838596.squirrel@www.dunaweb.hu>
In-Reply-To: <3557.213.163.11.81.1156838596.squirrel@www.dunaweb.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Böszörményi Zoltán wrote:
> Hi,
>
> I would like to run some diagnostics on a database
> process and I would like to know what flags it used
> for opening its files. Is there any way to get this info?
>
> Thanks in advance,
> Zoltán Böszörményi
>   
1. Look at the source code for the database - if you have it.
2. Run your database under strace, then search the voluminous
    output for "open" calls and look at the flags.
3. Patch your kernel to "printk" information whenever
    someone opens with O_DIRECT.

Helge Hafting
