Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265481AbUFRQNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265481AbUFRQNA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUFRQKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:10:08 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:29916 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265250AbUFRQJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:09:42 -0400
Message-ID: <40D313DC.7000202@blue-labs.org>
Date: Fri, 18 Jun 2004 12:10:04 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
References: <200406181611.37890.andrew@walrond.org>
In-Reply-To: <200406181611.37890.andrew@walrond.org>
Content-Type: multipart/mixed;
 boundary="------------000907000009020702060906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000907000009020702060906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Iptables should be using linux-libc-headers headers instead of kernel 
headers.

Remove -I$(KERNEL_DIR)/include from your makefile, see this patch here: 
http://ep09.pld-linux.org/~mmazur/linux-libc-headers/patches/iptables.patch 
<http://ep09.pld-linux.org/%7Emmazur/linux-libc-headers/patches/iptables.patch>

David

Andrew Walrond wrote:

>The addition of a
>	__user
>attribute to a line in
>	linux-2.6.7/include/linux/netfilter_ipv4/ip_tables.h
>causes iptables build to fail unless I export
>	CC="gcc -D__user= "
>
>Presumably ip_tables.h should include a header defining __user, or iptables 
>should include the relevant header before ip_tables.h ?
>
>Sorry if this has already been reported; Archive search found nothing on 
>either ML.
>
>Andrew Walrond
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

--------------000907000009020702060906
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------000907000009020702060906--
