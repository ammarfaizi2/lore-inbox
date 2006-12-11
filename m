Return-Path: <linux-kernel-owner+w=401wt.eu-S935336AbWLKO3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935336AbWLKO3Y (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935588AbWLKO3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:29:24 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:34077 "HELO
	smtp103.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S935336AbWLKO3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:29:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=anLO2GojssvVQQtO9XK0sKgopfHcuaf6pVjw45BTR9aXZ3/4DEg3JcjEPN3rtKC6irExgHKi82YEmFtW5NzxNSQ4iWXDZyYYrX403I8a5S7AYBqnUr77RFkUmBOVy7t7lARB3XTtlPIWZJfZyf9Y0DAHnIMoGcpONwl8+kYtkj4=  ;
X-YMail-OSG: 1a2VYzwVM1miWJg9o1zNqRZR14TPvFXhSeXsbLoTZAn8kbcWXgtl71jZtILvM0hW7G.gqB5SIwzMrBb_t0ZEOavqwsuC_HD8NNuTc2XS70WuhbDTYRtdQXIGIxNE_4x3Ijc_D89k_p9Gd.Sq0wLC4QAR189nuCfFCg--
Message-ID: <457D6B10.4010903@yahoo.com.au>
Date: Tue, 12 Dec 2006 01:28:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jiri Kosina <jikos@jikos.cz>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1
References: <20061211005807.f220b81c.akpm@osdl.org> <Pine.LNX.4.64.0612111137360.1665@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0612111137360.1665@twin.jikos.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina wrote:
> On Mon, 11 Dec 2006, Andrew Morton wrote:
> 
> 
>>Temporarily at
>>	http://userweb.kernel.org/~akpm/2.6.19-mm1/
> 
> 
> Am I the only one seeing something strange on ext3 with this kernel?
> 
> For example /etc/resolv.conf gets corrupted during the dhclient run. It 
> looks like this, after dhclient finishes:

Do you have CONFIG_DEBUG_VM turned on? I think we miss clearning BH_New
in some places, thus causing an error path to zero the block incorrectly
if we hit an error that CONFIG_DEBUG_VM makes much more likely.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
