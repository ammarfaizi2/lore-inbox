Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbUANQyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbUANQyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:54:35 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:7574 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S262030AbUANQyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:54:10 -0500
Message-ID: <40057412.9050306@backtobasicsmgmt.com>
Date: Wed, 14 Jan 2004 09:53:38 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kevin Corry <kevcorry@us.ibm.com>
CC: Wakko Warner <wakko@animx.eu.org>, Scott Long <scott_long@adaptec.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
References: <40033D02.8000207@adaptec.com> <40047AA6.4020200@domdv.de> <20040113183806.A16839@animx.eu.org> <200401141016.09361.kevcorry@us.ibm.com>
In-Reply-To: <200401141016.09361.kevcorry@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry wrote:

> I guess I simply don't understand the desire to partition MD devices when 
> putting LVM on top of MD provides *WAY* more flexibility. You can resize any 
> volume in your group, as well as add new disks or raid devices in the future 
> and expand existing volumes across those new devices. All of this is quite a 
> pain with just partitions.

In a nutshell: other OS compatibility. Not that I care, but they're 
trying to cater to the users that have both Linux and Windows (and other 
stuff) installed on a RAID-1 created by their BIOS RAID driver. In that 
situation, they can't use logical volumes for the other OS partitions, 
they've got to have an MSDOS partition table on top of the RAID device.

However, that does not mean this needs to be done in the kernel, they 
can easily use a (future) dm-partx that reads the partition table and 
tells DM what devices to make from the RAID device.

