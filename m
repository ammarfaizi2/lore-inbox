Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269696AbTG1NSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269661AbTG1NQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:16:43 -0400
Received: from nic.bme.hu ([152.66.115.1]:65502 "EHLO nic.bme.hu")
	by vger.kernel.org with ESMTP id S269617AbTG1NQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:16:21 -0400
Message-ID: <3F252542.3050703@namesys.com>
Date: Mon, 28 Jul 2003 17:29:38 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
Cc: Nikita Danilov <Nikita@Namesys.COM>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
References: <3F1EF7DB.2010805@namesys.com>	 <1059062380.29238.260.camel@sonja>	 <16160.4704.102110.352311@laputa.namesys.com>	 <1059093594.29239.314.camel@sonja>	 <16161.10863.793737.229170@laputa.namesys.com>	 <1059142851.6962.18.camel@sonja>  <3F23CCBC.9070600@namesys.com>	 <1059315409.10692.215.camel@sonja>  <3F251A97.9010409@namesys.com> <1059397619.31053.27.camel@sonja>
In-Reply-To: <1059397619.31053.27.camel@sonja>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:

>Am Mon, 2003-07-28 um 14.44 schrieb Hans Reiser:
>
>  
>
>>>This looks fine for normal harddrives put on flash you'd probably like
>>>to write the data evenly over the free space in some already formatted
>>>section still leaving the oportunity to format some other sectors to not
>>>run out of space.
>>>      
>>>
>
>  
>
>>I was not able to parse the sentence above.;-)
>>    
>>
>
>s/put/but/
>
>As already mentioned the flash chips have to be erased before they can
>be written. The erasesize is much larger than the typical block size
>which means that although a block doesn't contain valid data it still
>contains something which means that it cannot be written until it was
>erased. That's why JFFS2 is using garbage collection to reclaim unused
>but (at the moment) unusable space.
>
>  
>
>>No, you could be more clever than that.
>>    
>>
>
>Sure. :)
>
>  
>
If you feel ambitious, try increasing the reiser4 node size to equal the 
erase size.  This requires changes to VM though.

-- 
Hans


