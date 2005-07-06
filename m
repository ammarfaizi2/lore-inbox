Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVGFUCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVGFUCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVGFUB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:01:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:17372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262401AbVGFRRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:17:41 -0400
Date: Wed, 6 Jul 2005 10:17:26 -0700
From: Greg KH <greg@kroah.com>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
       Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050706171726.GA27902@kroah.com>
References: <1120668881.8328.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120668881.8328.1.camel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 11:54:41AM -0500, Timothy R. Chavez wrote:
> To implement this feature we rely on the concepts of a "watch" and
> "watch list".  Directories hold lists of "watches" (ie: "watch lists")
> that describe auditable file names one level beneath them.  If a file 
> holds a pointer into a "watch list" it is auditable.  When accessed by 
> a system call, information about the inode and its "watches" is added 
> to the audit context of the current task (an inode may have multiple 
> "watches" if a hard link to a "watched" file is itself being "watched")
> which is sent to user space upon system call exit.  

This sounds almost identical to inotify.  Is there some way you could
use that instead?  If not, you should explain why in your patch
introduction.

thanks,

greg k-h
