Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUD1Vv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUD1Vv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUD1VvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:51:25 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:42721 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261418AbUD1VtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:49:05 -0400
Message-ID: <409026CE.8050905@us.ibm.com>
Date: Wed, 28 Apr 2004 16:49:02 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: userspace pci config space accesses
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently ran into a problem where lspci was trying to read pci config space
of a pci adapter while the device driver for that adapter was running BIST
on it. On ppc64, this resulted in a PCI error and puts the slot into an error
state making it unusable for the remainder of that system boot. Should there
be some blocking in place so that userspace pci config reads will not occur
in these windows or is using tools like lspci user beware? Part of my problem
was that lspci was being called as a result of a boot script so on a particular
machine I was hitting this every boot.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

