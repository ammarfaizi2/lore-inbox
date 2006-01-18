Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWARLAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWARLAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWARLAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:00:30 -0500
Received: from grex.cyberspace.org ([216.86.77.194]:40453 "EHLO
	grex.cyberspace.org") by vger.kernel.org with ESMTP
	id S1030213AbWARLA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:00:29 -0500
Date: Wed, 18 Jan 2006 06:00:22 -0500
From: Roopesh <roopesh@cyberspace.org>
To: linux-kernel@vger.kernel.org
Subject: Synchronization between VFS and special IO requests to a block device.
Message-ID: <20060118110022.GA32663@grex.cyberspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,
  
	I have an SD card, a partition of which is mounted and is accessed
  only through VFS, and certain sectors out of this partition having
  some special data which is accessed by the applications only through
  certain ioctls to the device. 
  
  My problem is in synchronizing/serializing these two accesses to the
  hardware, especially since I dont want a VFS request to be handled 
  by the driver inbetween two specific ioctls.  I understand that the
	strategy routine should be atomic and that it cant wait on a lock or 
	sleep.  Any pointers/suggestions/help?

  Mine is a 2.4 kernel with a uni-processor.

  Thanks in Advance,

  Roopesh.
  PS: Kindly mark a CC: to me if posting. Thanks.
