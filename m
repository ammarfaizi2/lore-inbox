Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWDSM53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDSM53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWDSM52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:57:28 -0400
Received: from emulex.emulex.com ([138.239.112.1]:5058 "EHLO emulex.emulex.com")
	by vger.kernel.org with ESMTP id S1750730AbWDSM51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:57:27 -0400
Message-ID: <444633B5.5030208@emulex.com>
Date: Wed, 19 Apr 2006 08:57:25 -0400
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com>
In-Reply-To: <20060418160121.GA2707@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2006 12:57:25.0428 (UTC) FILETIME=[CE5DB740:01C663B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

To take netlink to where we want to use it within the SCSI subsystem (as
the mechanism of choice to replace ioctls), we're going to need to pass
user-space buffer pointers.

What is the best, portable manner to pass a pointer between user and kernel
space within a netlink message ?  The example I've seen is in the iscsi
target code - and it's passed between user-kernel space as a u64, then
typecast to a void *, and later within the bio_map_xxx functions, as an
unsigned long. I assume we are going to continue with this method ?

-- james s
