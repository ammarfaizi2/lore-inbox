Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWEYGDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWEYGDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 02:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEYGDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 02:03:37 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:30904 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964858AbWEYGDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 02:03:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2dWydTtUk5h2hndoHGUhjrYyAlPqee7MOeK4yKPp0X2qs28QM85mmk9nJ4lpzU2IrfEez6bKwK8uUzlIJAp+2UAwwCIlcsqGSPWKg8+YVfnRqhceh5mWmAk/OI5KpOlmqWs0NIRkTqTYtVEw0rE3GYxpD4iInk5XJv+aB/GiTJo=  ;
Message-ID: <447548B3.2000203@yahoo.com.au>
Date: Thu, 25 May 2006 16:03:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/33] readahead: state based method - data structure
References: <20060524111246.420010595@localhost.localdomain> <348469542.39504@ustc.edu.cn>
In-Reply-To: <348469542.39504@ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:

>Extend struct file_ra_state to support the adaptive read-ahead logic.
>

Another nitpick: It is usually OK to do these things in the same patch
that actually uses the new data (or functions -- eg. patch 15).

If the addition is complex or in a completely different subsystem
(eg. your rescue_pages function), _that_ can justify it being split
into its own patch. Then you might also prepend the subject with mm:
and cc linux-mm to get better reviews.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
