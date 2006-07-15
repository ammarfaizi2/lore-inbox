Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946005AbWGOHzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946005AbWGOHzP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 03:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946001AbWGOHzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 03:55:15 -0400
Received: from wavehammer.waldi.eu.org ([82.139.201.20]:8363 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1946005AbWGOHzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 03:55:14 -0400
Date: Sat, 15 Jul 2006 09:55:12 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Marcel Holtmann <holtmann@redhat.com>
Subject: Re: Linux 2.6.17.5
Message-ID: <20060715075512.GA1666@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Marcel Holtmann <holtmann@redhat.com>
References: <20060715030047.GC11167@kroah.com> <Pine.LNX.4.64.0607142217020.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607142217020.5623@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 10:21:22PM -0700, Linus Torvalds wrote:
> It still leaves the whole issue of whether /proc should honor chmod AT ALL 
> open,

Hmm, can you explain why notify_change (fs/attr.c) don't bail out if the
inode lacks the setattr function and instead just sets the new
permissions?

I really think this is the wrong way and inodes which want this default
behaviour should explicitely define it.

Bastian

-- 
Each kiss is as the first.
		-- Miramanee, Kirk's wife, "The Paradise Syndrome",
		   stardate 4842.6
