Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVIZX2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVIZX2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVIZX2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:28:34 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:34923 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932519AbVIZX2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:28:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=bq7YrOXECKRvDU5Fn3reG1L3RAEJ1+sm2YMf5a7MSlLSmWuWLS3kjm8yOAiGW5/QiUrrbpD0fyPt0jaiP7foPOJkge0KvLqHSu9R5v1pUZZs18NMEukk7zHn9FDler9oBcok6pbI/qbV/362dF2pu4QKjs9GPvVRa15MxJrIGPo=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: LKML <linux-kernel@vger.kernel.org>
Subject: Crazy Idea: Replacing /dev using sysfs over time
Date: Mon, 26 Sep 2005 19:28:18 -0400
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261928.20701.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if in the future, we can just eliminate /dev altogether (or map it 
via sysfs until older apps move away from /dev). It just seems we could 
represent major,minor in a sysfs node: 

        /sys/class/block/
        `-- sda
            |-- sda1
                    | - major
                    | - minor
                    | - raw
            |-- sda2
                    | - major
                    | - minor
                    | - raw
            `-- sda3

and so forth, or under a different branch elsewhere.

Does it make sense? Logical? Illogical? Do we really need /dev other than for 
historical/legacy purposes?

Shawn.


