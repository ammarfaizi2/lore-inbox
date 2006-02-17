Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWBQCSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWBQCSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 21:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWBQCSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 21:18:20 -0500
Received: from ns1.suse.de ([195.135.220.2]:10424 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751191AbWBQCSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 21:18:20 -0500
From: Andi Kleen <ak@suse.de>
To: Zan Lynx <zlynx@acm.org>
Subject: Re: Wrong number of core_siblings in sysfs for Athlon64 X2
Date: Fri, 17 Feb 2006 03:18:15 +0100
User-Agent: KMail/1.8.2
Cc: Jesper Juhl <jesper.juhl@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
References: <9a8748490602161346x6e2802e8r4edf7dcbdafa5e17@mail.gmail.com> <9a8748490602161408i736a7ab3vef09f3e1c95916fe@mail.gmail.com> <1140142257.29021.31.camel@localhost>
In-Reply-To: <1140142257.29021.31.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602170318.15511.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 03:10, Zan Lynx wrote:

> It seems to me that this could be confusing for a lot of people who are
> casually browsing through sysfs.  Why not name core_siblings something
> like core_sibling_bitmap? 

Because it's already a fixed ABI that is put in stone.

The only way to do what you want would be to add a new field
and keep the old one alone, but frankly your rationale for 
it ("could be confusing to someone") doesn't seem convincing enough 
for such a thing.  Especially since each sysfs field can
cost considerable memory when a dentry and a inode have to be allocated
for it.

I guess if you worry about such people a better way to help
them would be to write them a frontend that displays
the information in there in nice form.

-Andi
