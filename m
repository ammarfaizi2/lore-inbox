Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbUBOLg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 06:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUBOLg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 06:36:56 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:15785 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264481AbUBOLgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 06:36:55 -0500
Message-ID: <402F59B0.8080707@colorfullife.com>
Date: Sun, 15 Feb 2004 12:36:16 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zohn_ming wu <wu_zohn_ming@yahoo.com>
CC: linux-kernel@vger.kernel.org, pgsql-hackers@postgresql.org
Subject: Re: [HACKERS] friday 13 bug?
References: <20040214234405.96047.qmail@web41204.mail.yahoo.com>
In-Reply-To: <20040214234405.96047.qmail@web41204.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zohn_ming wu wrote:

>swap_free: Bad swap file entry 00000004
>
Do you use ECC memory, is ECC enabled in the BIOS [and does it work - 
some vendors lie about ECC support]?

I would bet that it's a soft memory error: 00000000 means not used. One 
bit differs, and the kernel complains about the invalid value. I think 
the following oops is a side effect of the bad swap entry.
Do you have timestaps in the system log? Is the swap error just before 
the BUG in buffer.c?

--
    Manfred


