Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264424AbUENCUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbUENCUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 22:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUENCUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 22:20:31 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:27007 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264424AbUENCUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 22:20:31 -0400
Message-ID: <40A42CEB.2000007@yahoo.com.au>
Date: Fri, 14 May 2004 12:20:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] truncate vs add_to_page_cache race
References: <40A42892.5040802@yahoo.com.au>
In-Reply-To: <40A42892.5040802@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Hi,
> I think there is a race between truncate and do_generic_mapping_read.

> Comments? Too ugly? Have I've missed something?

Hmm, no I think the right timing can still cause readpage to see
the shortened i_size and fill the page with zeros.
