Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWA0UN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWA0UN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWA0UN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:13:28 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:23309 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1160999AbWA0UN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:13:28 -0500
Message-ID: <43DA7ED9.4090802@symas.com>
Date: Fri, 27 Jan 2006 12:13:13 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: davids@webmaster.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKEEHCJLAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEHCJLAB.davids@webmaster.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 	We don't agree on what the specification says.
>
>   
>> Why do you suppose that is?
>>     
>
> 	Why do I suppose what? I find the specification perfectly clear and your
> reading of it incredibly strained for the three reasons I stated.
>   

Oddly enough, you said 
http://groups.google.com/group/comp.programming.threads/msg/28b58e91886a3602?hl=en&
"Unfortunately, it sounds reasonable"  so I can't lend credence to your 
stating that my reading is incredibly strained. The fact that 
LinuxThreads historically adhered to my reading of it lends more weight 
to my argument. The fact that people accepted this interpretation for so 
many years lends further weight. In light of this, it is your current 
interpretation that is incredibly strained, and I would say, broken.

You have essentially created a tri-state mutex. (Locked, unlocked, and 
sort-of-unlocked-but-really-reserved.) That may be a good and useful 
thing in its own right, but it should not be the default behavior.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

