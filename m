Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWHIXpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWHIXpJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWHIXpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:45:09 -0400
Received: from main.gmane.org ([80.91.229.2]:2186 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750712AbWHIXpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:45:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] arch/i386/kernel/cpu/transmeta.c, kernel 2.6.17.8
Date: Wed, 09 Aug 2006 23:30:33 +0200
Organization: Palacky University in Olomouc
Message-ID: <ebdr6i$8nj$1@sea.gmane.org>
References: <b572c9e10608091049q5223adddxb2fd854c31877670@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.192.40
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <b572c9e10608091049q5223adddxb2fd854c31877670@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forrest Voight:
 > Corrects warning:
 > arch/i386/kernel/cpu/transmeta.c: In function 'init_transmeta':
 > arch/i386/kernel/cpu/transmeta.c:12: warning: 'cpu_freq' may be used
 > uninitialized in this function
 > -       unsigned int cpu_rev, cpu_freq, cpu_flags, new_cpu_rev;
 > +       unsigned int cpu_rev, cpu_freq = 0, cpu_flags, new_cpu_rev;

If one doesn't want to add more init code, but variable indeed used 
uninitialazed, in GCC 3.X struct may be used, GCC 4.X needs 'volatile'.

