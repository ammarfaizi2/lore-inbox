Return-Path: <linux-kernel-owner+w=401wt.eu-S965166AbXAJXOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbXAJXOX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbXAJXOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:14:23 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:46785 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965166AbXAJXOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:14:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2iuHAj75OxjtmygqbbORs7Hrsy1CsQyCK7EoQ+4Mw0n+csJACWo0R/9KC21UY7lxPr9j/f+hivBtKotUHWep6TiUADoh9aMh2O+Li8nGYViD35lMM0u1P6tm5NMmBjr12JlxaEc3xtF/I6gSIpwrYnOCMgK1Dgb2uqtAJ4zyXqY=  ;
X-YMail-OSG: 9WKqHsAVM1nkeJAWdMrDP5x160CY7DOc85nvygbhTJv_PUpG28W.sep9TYPCzjZDNqlBGmZt4H7bgwCzjmFwWenXyf.2t1y8LV38poGh3Y3HrTwmRZguSI82teMStn9prpOO9CRK4WmcxXs-
Message-ID: <45A57333.6060904@yahoo.com.au>
Date: Thu, 11 Jan 2007 10:13:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
References: <20070110223731.GC44411608@melbourne.sgi.com> <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com> <20070110230855.GF44411608@melbourne.sgi.com>
In-Reply-To: <20070110230855.GF44411608@melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner wrote:
> On Wed, Jan 10, 2007 at 03:04:15PM -0800, Christoph Lameter wrote:
> 
>>On Thu, 11 Jan 2007, David Chinner wrote:
>>
>>
>>>The performance and smoothness is fully restored on 2.6.20-rc3
>>>by setting dirty_ratio down to 10 (from the default 40), so
>>>something in the VM is not working as well as it used to....
>>
>>dirty_background_ratio is left as is at 10?
> 
> 
> Yes.
> 
> 
>>So you gain performance by switching off background writes via pdflush?
> 
> 
> Well, pdflush appears to be doing very little on both 2.6.18 and
> 2.6.20-rc3. In both cases kswapd is consuming 10-20% of a CPU and
> all of the pdflush threads combined (I've seen up to 7 active at
> once) use maybe 1-2% of cpu time. This occurs regardless of the
> dirty_ratio setting.

Hi David,

Could you get /proc/vmstat deltas for each kernel, to start with?

I'm guessing CPU time isn't a problem, but if it is then I guess
profiles as well.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
