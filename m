Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVAYPMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVAYPMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVAYPK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:10:26 -0500
Received: from smtp.hickorytech.net ([216.114.192.16]:44681 "EHLO
	avalanche.hickorytech.net") by vger.kernel.org with ESMTP
	id S261976AbVAYPJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:09:53 -0500
Message-ID: <41F6613F.6030509@mnsu.edu>
Date: Tue, 25 Jan 2005 09:09:51 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>,
       David Greaves <david@dgreaves.com>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>, kruty@fi.muni.cz
Subject: Re: journaled filesystems -- known instability; Was: XFS: inode	with
 st_mode == 0
References: <20041209125918.GO9994@fi.muni.cz>	 <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org>	 <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net>	 <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com>	 <20050114182308.GE347@unthought.net> <20050116135112.GA24814@infradead.org>	 <20050117100746.GI347@unthought.net>  <41EC2ECF.6010701@mnsu.edu> <1106657254.1985.294.camel@sisko.sctweedie.blueyonder.co.uk>
In-Reply-To: <1106657254.1985.294.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:

>Hi,
>
>On Mon, 2005-01-17 at 21:31, Jeffrey Hundstad wrote:
>  
>
>>For more of this look up subjects:
>>  Bad things happening to journaled filesystem machines
>>  Oops in kjournald
>>    
>>
>
>That seems to have been due to the xattr problems recently fixed in
>Linus's tree.  The xattr race was allowing one process to delete an
>unshared xattr block while another was trying to share it, and the
>journaling code was getting upset when the second process then tried to
>commit the now-deleted block.
>  
>

Thanks for the update.

I wonder if there are several problems.  Alan Cox claimed that there was 
a fix in linux-2.6.10-ac10 that might alleviate the problem.

On linux-2.6.10-ac10 I've got one machine that's been up for 6 days now 
that would never last more then 1 before.  On the other hand I have one 
machine that did die after two days.

Does linux-2.6.11-rc2 have both the linux-2.6.10-ac10 fix and the xattr 
problem fixed?  If so, I'll test there.

-- 
Jeffrey Hundstad
