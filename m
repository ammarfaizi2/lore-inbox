Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbTJFSYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbTJFSYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:24:11 -0400
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:33514 "EHLO
	office.lsg.internal") by vger.kernel.org with ESMTP id S264000AbTJFSYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:24:06 -0400
Message-ID: <3F81B339.6040201@backtobasicsmgmt.com>
Date: Mon, 06 Oct 2003 11:23:53 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Christian Borntraeger <CBORNTRA@de.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
References: <OF6873DDE8.877C0EE8-ONC1256DB7.005F0935-C1256DB7.0060DEDC@de.ibm.com> <20031006174128.GA4460@kroah.com> <3F81ADC8.3090403@backtobasicsmgmt.com> <20031006181134.GA4657@kroah.com>
In-Reply-To: <20031006181134.GA4657@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> The hotplug event points to the sysfs location of the kobject, that's
> all.  libsysfs then takes that kobject location and sucks up all of the
> attribute information for that kobject, which udev then uses to
> determine what it should do.

This sounds like a very different issue than what I thought you said 
originally. Your other message said a "find over the sysfs tree", 
implying some sort of tree-wide search for relevant information. In 
fact, the "find" is only for attributes in the directory owned by the 
kobject, right? Once they have been "found", they will age out of the 
dentry/inode cache just like any other search results.

> 
> Unless we want to pass all attribute information through hotplug, which
> we do not.
> 

I agree, that would be difficult and hard to manage.

