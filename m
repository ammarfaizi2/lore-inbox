Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWCTVYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWCTVYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWCTVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:24:41 -0500
Received: from terminus.zytor.com ([192.83.249.54]:61368 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030370AbWCTVYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:24:40 -0500
Message-ID: <441F1D90.4080201@zytor.com>
Date: Mon, 20 Mar 2006 13:24:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Merge strategy for klibc
References: <441F0859.2010703@zytor.com> <20060320201905.GI20746@lug-owl.de>
In-Reply-To: <20060320201905.GI20746@lug-owl.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> 
> I haven't yet looked at your code, but what actually needs to be done?
> Defining syscall macros?
> 
> I'd probably give it a try for VAX.
> 

Each architecture needs an assembly stub generator for most syscalls, a 
crt0.S, plus adjustments for which syscalls are "special" (as in special 
ed) on that architecture.  There are also a couple of header files which 
need per-architecture configuration information.  All in all it is 
usually a few hours worth of work, no more.

	-hpa
