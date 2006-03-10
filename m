Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWCJBle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWCJBle (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCJBle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:41:34 -0500
Received: from smtpout.mac.com ([17.250.248.85]:1495 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751191AbWCJBld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:41:33 -0500
In-Reply-To: <1141923743.17294.8.camel@localhost.localdomain>
References: <20060309042744.GA23148@redhat.com> <20060308.203204.115109492.davem@davemloft.net> <20060309044025.GS27946@ftp.linux.org.uk> <1141923743.17294.8.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0A5868C4-CC2D-443D-8340-9F0AB2E0A94C@mac.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, "David S. Miller" <davem@davemloft.net>,
       davej@redhat.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: filldir[64] oddness
Date: Thu, 9 Mar 2006 20:41:08 -0500
To: "Bryan O'Sullivan" <bos@serpentine.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 9, 2006, at 12:02:22, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 04:40 +0000, Al Viro wrote:
>> On Wed, Mar 08, 2006 at 08:32:04PM -0800, David S. Miller wrote:
>>> I think coverity is being trigger happy in this case :-)
>>
>> If that's coverity, I'm very disappointed and more than a little  
>> suspicious about the quality of their results.
>
> About half of the ~50 reports I've looked at so far in their  
> database have been false positives.  In most of those cases, it's  
> not obvious how a checker might have gotten them right instead,  
> though.

Yeah, IMHO it's not really worth optimizing for the obscure and oddly- 
defined cases unless you can actually find valid places where that  
code comes up understandably.  In this particular case, the Coverity  
checker is indirectly pointing out that the code is confusing to the  
reader and could inadvertently be massively broken by changing the  
type of d_name.

Cheers,
Kyle Moffett

