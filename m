Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbTG1Nfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269537AbTG1Nfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:35:41 -0400
Received: from nic.bme.hu ([152.66.115.1]:41693 "EHLO nic.bme.hu")
	by vger.kernel.org with ESMTP id S269451AbTG1Nfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:35:37 -0400
Message-ID: <3F2529C5.9050401@namesys.com>
Date: Mon, 28 Jul 2003 17:48:53 +0400
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, in summary, reiser4 will do a good job of flushing in large batches 
using large bios, and that is most of what you can do to optimize for 
large erase size.

Things that could be added: improved compression for small files, 
garbage collection based freeing of unused blocks, increasing node size 
to equal erase size.

We can add such features for a fee, or you can code them yourself and 
send us a patch.

If I am wrong about compact flashes all having hardware wear leveling so 
that FAT can be used on them, then you can add wear leveling to the list 
of features desirable.

-- 
Hans


