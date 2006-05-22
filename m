Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWEVAJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWEVAJy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWEVAJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:09:54 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:46986 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964957AbWEVAJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:09:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pVums11Z4RPwI4Qxh2YDVat0ErxtjuuGrZWUzhIKYi8UH3npleZRnKUPScH83p+v7BMuLM6TfEQP0DbhfR9UL/ldixgrbhmMZympJ3XMjIzMGp1pJFkD02hgxQizJ712DzlXAVgBHEr1LOBX15YKGTFoy6t8KFo1Sj3oP2m/bvI=  ;
Message-ID: <44710144.7090105@yahoo.com.au>
Date: Mon, 22 May 2006 10:09:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
CC: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure.
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs> <20060521091022.GA3468@taniwha.stupidest.org> <014601c67cb9$4f235f30$1800a8c0@dcccs> <20060521102642.GB5582@taniwha.stupidest.org> <44705699.3080401@yahoo.com.au> <024901c67cdf$1e1ce840$1800a8c0@dcccs>
In-Reply-To: <024901c67cdf$1e1ce840$1800a8c0@dcccs>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haar János wrote:

> I did it allready, and it looks like solves the problem.
> Yesterday i have more than 6 random reboots, and after i set from 3800 to
> 16000 the min free limit, i have none at this point. :-)
> 
>  15:51:45 up  7:21,  1 user,  load average: 0.85, 0.79, 0.67

Oh that's good. It's sad that you had random reboots though :(

> 
> Anyway, i interested about cache/buffer mechanism, because i have some
> performance problems too, and i can see, these systems wastes the half of
> memory instead of speeds up the operation.

Yeah, as I said, block device's pagecache (aka buffercache) can't
use highmem. If nbd can export regular files as block devices, or
you use loop devices from regular files, that might help (or slow
things down :P).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
