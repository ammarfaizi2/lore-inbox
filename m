Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTFHANC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTFHANC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:13:02 -0400
Received: from oak.sktc.net ([64.71.97.14]:17816 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S264069AbTFHANA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:13:00 -0400
Message-ID: <3EE282B4.2010207@sktc.net>
Date: Sat, 07 Jun 2003 19:26:28 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [FUN] Re: [PATCH] Move BUG/BUG_ON/WARN_ON to asm headers
References: <16097.56616.35782.882995@argo.ozlabs.ibm.com>	 <20030607145633.V626@nightmaster.csn.tu-chemnitz.de> <1055028601.7146.0.camel@chtephan.cs.pocnet.net>
In-Reply-To: <1055028601.7146.0.camel@chtephan.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> Hi Ingo!
> 
>> On Sat, Jun 07, 2003 at 10:40:08PM +1000, Paul Mackerras wrote:
>> > +struct bug_entry *module_find_bug(unsigned long bugaddr)
>> 
>> A wet dream of many driver writers has come true: A function,
>> which finds the bug in their module ;-)
> 
> *The* bug? That sounds very optimistic. ;-)
> 

Well, y'just gotta iterate...

struct bug_entry *x = module_find_bug(my_module);
while (x)
{
    module_fix_bug(my_module,x);
    x = module_find_bug(my_module)
}

So, who will write module_fix_bug?


