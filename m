Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUHQMEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUHQMEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUHQMEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:04:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:63131 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S266425AbUHQMEV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:04:21 -0400
Date: Tue, 17 Aug 2004 17:34:06 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: akpm@osdl.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       mbligh@aracnet.com, litke@us.ibm.com, ebiederm@xmission.com
Subject: [RFC]Kexec based crash dumping
Message-ID: <20040817120239.GA3916@in.ibm.com>
Reply-To: hari@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patches that follow contain the initial implementation for kexec based
crash dumping that we are working on. I had sent this to the fastboot mailing 
list a couple of weeks ago and this set of patches includes the changes made as
per feedback from Andrew, Eric and others.

Main Idea

- Whenever a panic occurs, reboot to a new kernel using kexec using a small
  amount of memory (16MB). The rest of the memory is preserved across the
  reboot.
- In the second kernel, the memory contents from the failed kernel is 
  available as an ELF format file for write-out.

Details on the design and implementation and on how to setup this facility
are available in the first of the patches that follow. The patches have
been made for the 2.6.8.1 kernel.

Kindly review these patches and provide feedback.

Thanks to Martin Bligh and Suparna for the design ideas and to Adam Litke
who hacked up most of the memory preserving reboot code and the dump
device abstraction code.

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
