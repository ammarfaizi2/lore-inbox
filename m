Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbVKIVhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbVKIVhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbVKIVhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:37:55 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:64347 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751495AbVKIVhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:37:54 -0500
Message-ID: <43726C1F.6050003@oracle.com>
Date: Wed, 09 Nov 2005 13:37:35 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] aio: make ctx ref debugging depend on DEBUG
References: <20051109211758.25027.78199.sendpatchset@volauvent.pdx.zabbo.net> <20051109211808.25027.75305.sendpatchset@volauvent.pdx.zabbo.net> <20051109212515.GJ14452@kvack.org>
In-Reply-To: <20051109212515.GJ14452@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> NAK.  There's now no way for code outside aio.c to use the reference counting
> on iocbs, which is needed in other code.

Where is this other code?

In any case, sure, I'll rework it to leave the ctx refcounting in aio.h and
will add a comment.  Presumably we're not happy with the existing
ref-after-racing-free bug.

- z
