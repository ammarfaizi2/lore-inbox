Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWF2Rqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWF2Rqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWF2Rqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:46:37 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:55993 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751091AbWF2Rqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:46:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2ETlIQJAS7/XHvGA5cJEMEkhiC8sYywC3eER8iluNRbo3mK4Rom1VscTicvOCd8ywfosSyBZHnVsGwFLV8QlXQdsDr7XG7dfw8RQnnoXZjPHEhOaxer27VZ8d6MNLCn13rimx3yDUTAwqsbqar8/fE+2SQbRn6RA1XrvH4oA/58=  ;
Message-ID: <44A411F8.2020404@yahoo.com.au>
Date: Fri, 30 Jun 2006 03:46:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Greg Bledsoe <greg.bledsoe@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: pmap, smap, process memory utilization
References: <dba10b900606271140o64b60c97kecb8177f801ff9f4@mail.gmail.com>  <Pine.LNX.4.58.0606280511320.32286@gandalf.stny.rr.com> <dba10b900606280855g6d415441y92c46ca83c74a469@mail.gmail.com> <Pine.LNX.4.58.0606290220220.19156@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0606290220220.19156@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 28 Jun 2006, Greg Bledsoe wrote:

>>That seems to be what I am hearing in previous lkml discussions.
>>
>>Also, since it seems virtually impossible to get this data on a
>>per-process basis, does smap suffer from these same difficulties, as
>>it seems to calculate this information when asked, and not keep it
>>from process start time.

Hi Greg,

smap should do what you want. Rss is total memory used, and the
following 4 fields are the type of pages used -- shared meaning
it is mapped by more than one process.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
