Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVA0COT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVA0COT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVAZXqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:46:06 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:20423 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261979AbVAZTJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:09:18 -0500
Message-ID: <41F7EABE.2050900@nortelnetworks.com>
Date: Wed, 26 Jan 2005 13:08:46 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: breeves@redhat.com
CC: linux-os@analogic.com, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Antill <james.antill@redhat.com>
Subject: Re: don't let mmap allocate down to zero
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>	 <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>	 <41F7D4B0.7070401@nortelnetworks.com> <1106762261.10384.30.camel@breeves.surrey.redhat.com>
In-Reply-To: <1106762261.10384.30.camel@breeves.surrey.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryn Reeves wrote:

> RETURN VALUE
>   For calloc() and malloc(), the value returned is a pointer to the
>   allocated  memory,  which  is suitably aligned for any kind of
>   variable, or NULL if the request fails.
> 
> This could get pretty confusing if NULL was a valid address...

Internally the library can use mmap().  Presumably they will map a 
MAP_FAILED return code from mmap() to a NULL return code in malloc().

Chris
