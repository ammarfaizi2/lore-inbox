Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbUK3Xq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUK3Xq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUK3Xn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:43:59 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:4999 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262449AbUK3XmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:42:05 -0500
Message-ID: <41AD03F7.6020803@nortelnetworks.com>
Date: Tue, 30 Nov 2004 17:36:23 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: Mariusz Mazur <mmazur@kernel.pl>, Sam Ravnborg <sam@ravnborg.org>,
       Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411301243000.22796@ppc970.osdl.org> <20041130223359.GA15443@mars.ravnborg.org> <200411302344.21907.mmazur@kernel.pl> <20041130230325.GY26051@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041130230325.GY26051@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Tue, Nov 30, 2004 at 11:44:21PM +0100, Mariusz Mazur wrote:

>>Wrong. These dirs must be linked to /usr/include so they must have more 
>>meaningfull names.
> 
> 
> WTF?  I've got a dozen kernel trees hanging around, which one (and WTF any,
> while we are at it) should be "linked to"?

Just my point of view, but I'd love to have /usr/include/linux and 
/usr/include/asm linked to the headers for the currently running kernel.

For a while I was playing with adding a bunch of new syscalls, and it sure would 
have been nice to be able to just include <asm/unistd.h> and get the up-to-date 
syscalls for whatever kernel I happened to be running.

I've since switched to using a device node and doing ioctl() calls to get around 
this, but the issue still stands as I need to either import the ioctl() command 
numbers and data types, or else I have to duplicate the header in userspace and 
keep the two versions up to date.

Chris
