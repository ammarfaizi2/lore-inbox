Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUBPRb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUBPRb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:31:59 -0500
Received: from main.gmane.org ([80.91.224.249]:32947 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265701AbUBPRb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:31:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: mount & fstype auto
Date: Mon, 16 Feb 2004 18:25:54 +0100
Message-ID: <c0quq8$8sg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508a5635.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if fstab contains an entry like
   /dev/hda5 /mnt/test auto
and if this get's mounted, the mtab will also contain the fstype "auto".

Wouldn't it be reasonable to put the detected fstype in the mtab?

I'm sure there exists a Map somewhere inside the kernel that maps the 
fstype-string to the appropriate routines. My question is, if this 
mapping is reversible.

My intention is to write a patch for mount that writes the detected 
fstype into the mtab or writing a patch for updatedb from the slocate 
package.

updatedb has a blacklist of fstypes that it won't search for files.
For both patches i would need to syscall that allows me to query the 
fstype-string for a given path.

Do you see any possibility?

Thx
   Sven

