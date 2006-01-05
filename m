Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWAEQpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWAEQpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWAEQpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:45:33 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:910 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751778AbWAEQpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:45:32 -0500
Date: Thu, 5 Jan 2006 11:45:31 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       <autofs@linux.kernel.org>, <raven@themaw.net>
Subject: Re: [linux-usb-devel] Re: BUG: 2.6.14/2.6.15: USB storage/ext2fs
 uninterruptable sleep
In-Reply-To: <87irsypswi.fsf@hardknott.home.whinlatter.ukfsn.org>
Message-ID: <Pine.LNX.4.44L0.0601051143480.5520-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Roger Leigh wrote:

> With some further testing with both usb-storage and ub, both show the
> same behaviour when using autofs4 _or_ autofs.  When mounting by hand,
> the problem does not occur.  While broken on 2.6.15 and 2.6.14, it
> does appear to work on 2.6.13; I can't test earlier kernels at the
> moment because of udev--I'll have to remove it first.

By any chance, does autofs or autofs4 mount your device with -o sync?  
Doing that with flash memory devices is a grave mistake -- although it 
shouldn't cause the sort of lock-up you described.

Alan Stern


