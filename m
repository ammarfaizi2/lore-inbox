Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUE0OqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUE0OqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUE0OqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:46:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264595AbUE0Op7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:45:59 -0400
Message-ID: <40B5FF16.7030503@redhat.com>
Date: Thu, 27 May 2004 10:45:42 -0400
From: Nobuhiro Tachino <ntachino@redhat.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, tachino@jp.fujitsu.com
CC: Takao Indoh <indou.takao@soft.fujitsu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Diskdump - yet another crash dump function
References: <20pwP-55v-5@gated-at.bofh.it> <m3k6yyuhvz.fsf@averell.firstfloor.org>
In-Reply-To: <m3k6yyuhvz.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I like the concept - it's basically netconsole for SCSI drivers
> and the driver changes are surprisingly simple and clean.
> 
> But it would be better if it coexisted with LKCD so that netdump
> would also work. Can't you make it a low level driver for LKCD? 

Diskdump can exist with netdump without LKCD. Actually in our
system, diskdump and netdump both exist and can be selected by
module loading. When both modules are loaded, diskdump runs first
and if it detects I/O error when writing dump, it falls backs
to netdump.

---
Nobuhiro Tachino
FUJITSU LIMITED
