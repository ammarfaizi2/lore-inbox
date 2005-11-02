Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbVKBOOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbVKBOOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbVKBOOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:14:38 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:39141 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932711AbVKBOOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:14:37 -0500
Message-ID: <4368C926.2040102@jp.fujitsu.com>
Date: Wed, 02 Nov 2005 23:11:50 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: clameter@engr.sgi.com
CC: Hirokazu Takahashi <taka@valinux.co.jp>, rob@landley.net, akpm@osdl.org,
       torvalds@osdl.org, kravetz@us.ibm.com, raybry@mpdtxmail.amd.com,
       linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       haveblue@us.ibm.com, magnus.damm@gmail.com, pj@sgi.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
References: <Pine.LNX.4.62.0511010943310.16224@schroedinger.engr.sgi.com>	<20051102.143047.35521963.taka@valinux.co.jp>	<Pine.LNX.4.62.0511020030210.19157@schroedinger.engr.sgi.com> <20051102.212651.25143264.taka@valinux.co.jp>
In-Reply-To: <20051102.212651.25143264.taka@valinux.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote:
> Hi Christoph,
> I've read the archive of lhms-devel.
> You're going to take in most of the original migration code
> except for some tricks to migrate pages which are hard to move.
> I think this is what you said the complexity, which you
> want to remove forever.
> 
> I have to explain that this complexity came from making the code
> guarantee to be able to migrate any pages. So the code is designed:
>   - to migrate heavily accessed pages.
>   - to migrate pages without backing-store.
>   - to migrate pages without I/O's.
>   - to migrate pages of which status may be changed during the migration
>     correctly.
> 
> This have to be implemented if the hotplug memory use it.
yes.

> It seems to become a reinvention of the wheel to me.
> 
Christoph, I think you should make it clear the advantage of your code
to the -mhp tree's. I think we can add migrate_page_to() easily to the
-mhp tree's as Takahashi said.

BTW, could you explain what is done and what is not in your patch set ?

-- Kame



