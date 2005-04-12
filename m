Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbVDLWKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbVDLWKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbVDLWGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:06:49 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:62938 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263007AbVDLWCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:02:44 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "J.A. Magallon" <jamagallon@able.es>
Date: Wed, 13 Apr 2005 07:55:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16988.17389.81020.101830@cse.unsw.edu.au>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What does 'WrongLevel' mean in RAID0 ?
In-Reply-To: message from J.A. Magallon on Tuesday April 12
References: <1113338725l.7969l.0l@werewolf.able.es>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 12, jamagallon@able.es wrote:
> Hi all...
> 
> I have a RAID0 setup on top of three IDE drives.
> mdadm monitor sends me mesages with:
> 
> DeviceDisappeared
> /dev/md0
> Wrong-Level
> 
> The RAID seems to be working well. Any pointer on what does this
> mean ?

 From  "man mdadm"  (if you know where to look)

       Follow or Monitor
              Monitor  one  or  more  md devices and act on any state changes.
              This is only meaningful for raid1, 4, 5, 6 or  multipath  arrays
              as  only  these  have  interesting state.  raid0 or linear never
              have missing, spare, or failed drives, so there  is  nothing  to
              monitor.

You are presumably trying to monitor a raid0 (which isn't meaningful)
and mdadm is telling you (in its own idiosyncratic way) that it isn't
going to monitor it.

NeilBrown
