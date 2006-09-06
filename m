Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWIFDgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWIFDgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 23:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWIFDgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 23:36:13 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:44466 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751692AbWIFDgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 23:36:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0e5s1v6zwH0N6incwWK+qhGrv+TSfxYXE5VgjY/ajRIsKkUPErOyaP+QGE+QrcbIhD8Rhr3PzVkKMpFKz60+humiGAgQrrfUwoZOjIOy7b5gNxgXmrCjI65aAZh5BvMczHV9r+D8jfsaHo2rC3rGV1FrC87GHfIoVYpKAqeWri8=  ;
Message-ID: <44FE4222.3080106@yahoo.com.au>
Date: Wed, 06 Sep 2006 13:36:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
References: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com>	 <17162.1157365295@warthog.cambridge.redhat.com>	 <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com>	 <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com>
In-Reply-To: <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:

> Yeah, I agree with most of your opinion. Using PG_slab is really a
> quickest way to determine the size of the object. But I think using a
> flag named "PG_slab" on a memory algorithm named "slob" seems not
> reasonable. It may confuse the people who start to read the kernel
> source code. So I'm writing to ask if there is a better solution to
> fix the issue.


No, confusing would be a "slab replacement" that doesn't provide the same
API as slab and thus requires users to use ifdefs.

I've already suggested exact same thing as David in the exact same situation
about 6 months ago. It is the right way to go.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
