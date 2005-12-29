Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVL2P4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVL2P4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVL2P4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:56:54 -0500
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:54750 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1750773AbVL2P4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:56:54 -0500
Message-ID: <43B40757.7040706@kolumbus.fi>
Date: Thu, 29 Dec 2005 17:57:11 +0200
From: =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>, Andi Kleen <ak@muc.de>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 write apic id fix
References: <20051229082709.GB1626@in.ibm.com>
In-Reply-To: <20051229082709.GB1626@in.ibm.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2|September 12, 2005) at 29.12.2005 17:56:37,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2|September
 12, 2005) at 29.12.2005 17:56:37,
	Serialize complete at 29.12.2005 17:56:37,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2|September
 12, 2005) at 29.12.2005 17:56:36,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2|September
 12, 2005) at 29.12.2005 17:56:46,
	Serialize complete at 29.12.2005 17:56:46
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:

>o Apic id is in most significant 8 bits of APIC_ID register. Current code
>  is trying to write apic id to least significant 8 bits. This patch fixes
>  it.
>
>o This fix enables booting uni kdump capture kernel on a cpu with non-zero
>  apic id.
>
>Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
>---
>
>  
>
What difference does it make in the first place? In 
APIC_init_uniprocessor() you write back the apic id read before from 
processor, not from mp table (because you wouldn't be in 
APIC_init_uniprocessor() otherwise).

--Mika

