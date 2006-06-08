Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWFHUlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWFHUlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWFHUlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:41:12 -0400
Received: from winds.org ([68.75.195.9]:11914 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S964992AbWFHUlK (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:41:10 -0400
Date: Thu, 8 Jun 2006 16:41:09 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Linux-kernel@vger.kernel.org
Subject: mmap/VM snapshot question
Message-ID: <Pine.LNX.4.63.0606081627360.16246@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have four processes accessing the same file using mmap() with MAP_SHARED.
I'd like to take a copy-on-write snapshot of that file so that I can do a
backup. However, if I try to start a fifth process and map the file with
MAP_PRIVATE, the copy-on-write only works one way; i.e. changes made by the
other processes can be visible by the backup process.

How do you get the Linux VM to reverse the copy-on-write, where the four
original processes can keep sharing their data and the fifth backup process
retains the data made at the time of the snapshot?

Thanks,
  -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
