Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbTH2CO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 22:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTH2CO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 22:14:26 -0400
Received: from user-0cal2fl.cable.mindspring.com ([24.170.137.245]:5539 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S262372AbTH2CO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 22:14:26 -0400
Message-ID: <3F4EB6F4.3010007@davehollis.com>
Date: Thu, 28 Aug 2003 22:14:12 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: We have ethtool_ops, any thoughts on miitool_ops?
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a driver is converted to use ethtool_ops, it does not seem to have 
the ability to support mii-tool any longer.  RedHat uses mii-tool to 
check for link before running dhclient so that you don't have to wait 
forever for dhclient to timeout if the connection is down (laptops, 
etc).  The typical way to support mii tool was to A) handle that case in 
the ethtool and call another big switch, or B) call the 
generic_mii_ioctl call with the mii struct to handle what you didn't 
handle under ethtool.    Some method similar to ethtool_ops would really 
be great.

