Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWDZRK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWDZRK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWDZRK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:10:59 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:50061 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932331AbWDZRK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:10:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=snzZbR7bFycCxNbTbhwsRPsc6EhSNAQT7Qpeh18dbR8fgDrAMOX4lKIiXmpcXD9y6OZFC5n/SZDQIEefiDD7y2s2PN0GN8UK2mfY4e4TF+tDj7CfiWgJh7wFnX+y97i2jo1e59fDBIx7DquMMXwDZ4AbmFP38C/1xsqFkqMiIzE=  ;
Message-ID: <444F53EE.7030802@yahoo.com.au>
Date: Wed, 26 Apr 2006 21:05:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Arjan van de Ven <arjan@infradead.org>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>  <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>  <1146038324.5956.0.camel@laptopd505.fenrus.org>  <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>  <1146040038.7016.0.camel@laptopd505.fenrus.org>  <20060426100559.GC29108@wohnheim.fh-wedel.de> <1146046118.7016.5.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:

> On Wed, 26 Apr 2006, Arjan van de Ven wrote:
> 
>>if you deref'd the pointer it'll optimize it away (assuming a new enough
>>gcc, like 4.1)
> 
> 
> Here are the numbers for allyesconfig on my setup.

25k out of 25,000k isn't _too_ bad.

On my kernel that should be less than 5k (unless drivers/fses
have a very different ratio of size change versus core code).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
