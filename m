Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVDFQtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVDFQtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 12:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVDFQtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 12:49:09 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:29536 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262249AbVDFQtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 12:49:06 -0400
Message-ID: <425412FB.7030209@yahoo.com.au>
Date: Thu, 07 Apr 2005 02:48:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
CC: LKML list <linux-kernel@vger.kernel.org>
Subject: Re: return value of ptep_get_and_clear
References: <a0b2cb42ff815dcf964b7a728f638b87@freescale.com>
In-Reply-To: <a0b2cb42ff815dcf964b7a728f638b87@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:
> ptep_get_and_clear has a signature that looks something like:
> 
> static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned 
> long addr,
>                                        pte_t *ptep)
> 
> It appears that its suppose to return the pte_t pointed to by ptep 
> before its modified.  Why do we bother doing this?  The caller seems 
> perfectly able to dereference ptep and hold on to it.  Am I missing 
> something here?
> 

You need to be able to *atomically* clear the pte and retrieve the
old value.

Nick

-- 
SUSE Labs, Novell Inc.

