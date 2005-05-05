Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVEECxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVEECxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 22:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVEECxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 22:53:23 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:7317 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261835AbVEECxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 22:53:18 -0400
Message-ID: <42798A95.6070909@cs.wisc.edu>
Date: Wed, 04 May 2005 19:53:09 -0700
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] add open iscsi netlink interface to iscsi transport class
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add the linux-iscsi-5.X/open-iscsi project's 
netlink interface to the iscsi transport class since the groups doing 
iSCSI over TCP (this module is completed now and will be submitted in a 
seperate mail), iSCSI over SCTP and iSER are using it for a common 
interface and to share code.

The answers to why netlink and why push so much to userspace can be 
found here http://open-iscsi.org/.

Patches

1. add-iscsi-netlink-def.patch - include/linux/netlink.h changes (added 
new protocol NETLINK_ISCSI)

2.  common-iscsi-headers.patch - Common header files:
  - iscsi_if.h (user/kernel #defines);
  - iscsi_proto.h (RFC3720 #defines and types);
  - iscsi_ifev.h (user/kernel events).

3. integrate-iscsi-netlink.patch - incorporate the 
open-iscsi/linux-iscsi netlink interface into the iscsi transport class.


Thanks,

Linux-iscsi Team
