Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbTAPAXY>; Wed, 15 Jan 2003 19:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTAPAXX>; Wed, 15 Jan 2003 19:23:23 -0500
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:38052 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S266941AbTAPAXW>; Wed, 15 Jan 2003 19:23:22 -0500
Message-ID: <3E25FD8C.1030103@cisco.com>
Date: Wed, 15 Jan 2003 16:32:12 -0800
From: "Jarrett L. Redd" <jredd@cisco.com>
Organization: Andiamo Systems, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/meminfo behaviour...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys, is this normal?

# head -2 /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  193830912 76816384 117014528        0   425984 72572928
                          ^^^^^^^^^
# sleep 1
# head -2 /proc/meminfo
         total:    used:    free:  shared: buffers:  cached:
Mem:  193830912 76869632 116961280        0   430080 72609792
                          ^^^^^^^^^
#

This is on a PC with no swap and no disk, booting off an initrd stored 
on a compact flash.  I can understand that while sleep is running, the 
amount of free memory is reduced.  Why does the number stay reduced even 
after it is done running?  No matter how long you wait, the number never 
comes back up.  Is the memory really gone or is there something I don't 
understand about /proc/meminfo?  Or does this have something to do with 
the ramdisk?  Thanks.

-Jarrett Redd

