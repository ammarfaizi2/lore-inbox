Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUH0MgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUH0MgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUH0MgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:36:03 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:55511
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S264371AbUH0Mew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:34:52 -0400
Message-ID: <412F2A6B.5080805@bio.ifi.lmu.de>
Date: Fri, 27 Aug 2004 14:34:51 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc1 hangs on mounting root-over-nfs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we run a diskless system where clients boot via pxelinux, get their IP
from kernel ip autoconfig and mount their root directory with root-over-nfs.
It all works fine with 2.6.8.1 and earlier.

Now I tested 2.6.9-rc1 (and also tried already with the patch that reverts
nfs_fh_copy() in case that was causing it, but it wasn't). The IP-Config part
goes fine and gets the right values. But then the clients hang:

...
Looking up port of RPC 10003/3 on xx.xx.1.132
portmap: server xx.xx.1.132 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 10003/3 on xx.xx.1.132
RPC: error 5 connecting to server 141.84.1.132
(same messages repeated a few times).


I didn't change the config compared to 2.6.8.1 (using the default and
adding some options of my own). The network driver is tg3 (for 3com
3c996bt cards).

There are now related messages in the nfs servers log. The last messages
I see there is the successful dhcp request.

Can I provide more information?

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

