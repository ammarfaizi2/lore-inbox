Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVCVEpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVCVEpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVCVEly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:41:54 -0500
Received: from mail.aknet.ru ([217.67.122.194]:11539 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262475AbVCVEkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:40:07 -0500
Message-ID: <423FA1B8.5000307@aknet.ru>
Date: Tue, 22 Mar 2005 07:40:24 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm1
References: <423EE354.ACFF446A@tv-sign.ru>
In-Reply-To: <423EE354.ACFF446A@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Oleg Nesterov wrote:
>>   x86: fix ESP corruption CPU bug (take 2)
> I think that Stas tries to steal 1024 bytes from kernel's memory ...
I think so too, sorry.
I simply copied that from the cpu_gdt_table
definition, and here's the mistake :(
Probably this:
---
$ nm -g vmlinux |grep cpu_gdt_table
c02d7000 D cpu_gdt_table
c037c300 D per_cpu__cpu_gdt_table
---
can be optimized too?

