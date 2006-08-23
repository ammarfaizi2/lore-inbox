Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWHWCCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWHWCCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 22:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWHWCCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 22:02:45 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:12041 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932240AbWHWCCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 22:02:45 -0400
Message-ID: <44EBB6FD.3080005@symas.com>
Date: Tue, 22 Aug 2006 19:01:33 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060716 SeaMonkey/1.5a
MIME-Version: 1.0
To: Nicholas Miell <nmiell@comcast.net>
CC: David Miller <davem@davemloft.net>, rdunlap@xenotime.net,
       johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org, drepper@redhat.com,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org
Subject: Re: The Proposed Linux kevent API
References: <1156281182.2476.63.camel@entropy>	 <20060822143747.68acaf99.rdunlap@xenotime.net>	 <1156287492.2476.134.camel@entropy>	 <20060822.160618.130612620.davem@davemloft.net> <1156296967.2476.200.camel@entropy>
In-Reply-To: <1156296967.2476.200.camel@entropy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
> Having looked all this over to figure out what it actually does, I can
> make the following comments:
>
> - there's a distinct lack of any sort of commenting beyond brief
> descriptions of what the occasional function is supposed to do
>
> - the kevent interface is all the horror of the BSD kqueue interface,
> but with no compatibility with the BSD kqueue interface.
>
> - lots of parameters from userspace go unsanitized, although I'm not
> sure if this will actually cause problems. At the very least, there
> should be checks for unknown flags and use of reserved fields, lest
> somebody start using them for their own purposes and then their app
> breaks when a newer version of the kernel starts using them itself.
>   


Which reminds me, why go through the trouble of copying the structs back 
and forth between userspace  and kernel space? Why not map the struct 
array and leave it in place, as I proposed back here?
http://groups.google.com/group/linux.kernel/browse_frm/ 
thread/57847cfedb61bdd5/8d02afa60a8f83af?lnk=gst&q=equeue&rnum= 
1#8d02afa60a8f83af

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

