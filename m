Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbSJUVfy>; Mon, 21 Oct 2002 17:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJUVfy>; Mon, 21 Oct 2002 17:35:54 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:39849 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261690AbSJUVfy>;
	Mon, 21 Oct 2002 17:35:54 -0400
Message-ID: <3DB47396.4070505@us.ibm.com>
Date: Mon, 21 Oct 2002 14:37:26 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
       Martin Bligh <mjbligh@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@osdl.org>
Subject: [rfc][patch] DriverFS Topology + per-node (NUMA) meminfo
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon,
	Here's I've been sitting on a bit too long.  This patch adds Topology 
information to driverfs, and adds a meminfo file to each node's 
directory which contains: <drum roll> that nodes memory info!
	Pat, I got rid of the per-arch callbacks, since they weren't doing 
anything even remotely useful yet, and they bloated the patch even 
further.  I left in the arch_info pointers so we can put the arch 
specific callbacks back in if anyone wants...  I've also rolled Martin's 
/proc/meminfo.numa patch into this.
	BTW, I have a patch that will changes the usage of 'int numnodes' into 
the more generic 'num_online_nodes()' and 'node_set_online()' calls. 
I'll be sending that patch momentarily also.
	As always: comment, question, and flame away!

Cheers!

-Matt

