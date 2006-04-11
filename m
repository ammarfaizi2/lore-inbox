Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWDKSI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWDKSI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWDKSI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:08:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13275 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750817AbWDKSIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:08:55 -0400
Date: Tue, 11 Apr 2006 11:08:41 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Binary sysfs blobs
Message-Id: <20060411110841.71390306.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.15; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg:

I was reviewing some patches here and noticed (yes, only now noticed) that
we have operations on binary blobs in fs/sysfs/bin.c. I thought it wasn't
part of the deal for sysfs, with one value per file and so on. I suppose
it's too late to debate now, but I have a couple of questions:

 - Do you know of any conventions which allow to determine which file
   is binary? Maybe the name starting with an underscore or something?

 - Is there a standing policy that reading from a sysfs file is not
   altering a state of the corresponding hardware? This is not related
   to blobs directly, but with people passing structs now, it's tempting
   to implement some extended protocols. I am concerned of stealing
   network packets by accident or something.

Greetings,
-- Pete
