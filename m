Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbTDRNNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 09:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbTDRNNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 09:13:16 -0400
Received: from mailbox.surfeu.fi ([213.173.154.4]:58898 "EHLO surfeu.fi")
	by vger.kernel.org with ESMTP id S263038AbTDRNNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 09:13:15 -0400
Message-ID: <3E9FFC92.DE4EBFB0@pp.inet.fi>
Date: Fri, 18 Apr 2003 16:24:34 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: akpm@digeo.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct loop_info
References: <UTC200304172334.h3HNYgI06614.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> The second part of this patch adds a new struct loop_info2
> in <linux/loop.h> identical to the old struct but with
> unsigned long long instead of dev_t.
> Now kernel and userspace use the same struct, simplifying life.
> 
> Unfortunately for compatibility some translation between
> loop_info and loop_info2 is required.

Andries, if you are going to define new struct loop_info2, please change
lo_offset to 64 bits, and add new 64 bit lo_size element. Specifying offset
without size is little bit silly.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
