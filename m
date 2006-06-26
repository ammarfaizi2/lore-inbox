Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWFZOH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWFZOH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWFZOH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:07:26 -0400
Received: from [195.23.16.24] ([195.23.16.24]:46487 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030212AbWFZOHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:07:22 -0400
Message-ID: <449FEA08.1080407@grupopie.com>
Date: Mon, 26 Jun 2006 15:07:04 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
References: <449C3FCA.5080501@mbligh.org> <20060623143004.6af78d68.akpm@osdl.org>
In-Reply-To: <20060623143004.6af78d68.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> And that's LIST_POISON1.
> 
> The only s_show()s I can see are in slab and in kallsyms.
>
> It would help if you could gdb these guys, work out file-n-line.

I just checked s_show in kernel/kallsyms.c and I can not see how it 
could BUG without BUG'ing in s_next first, because that function only 
formats the information that has been gathered by s_next.

> And it would be super-good if you could revert
> slab-stop-using-list_for_each.patch and retest.  

My bet goes to slab's s_show, too. Besides, that code in kallsyms has 
been like that for a very long time, IIRC.

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
