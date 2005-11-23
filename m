Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVKWRNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVKWRNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVKWRNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:13:10 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:61924 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751202AbVKWRNI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:13:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aauQW4XhAe4EOdARrCe/sWUqJNGjmDDabRDRIfk/BoyvSsZbF7yLXrjrbY/eVi8KB/QJemtmKIXEV+X7g7Sc5uZersT0yU4BmfY8i290PU/aae9Ox64e430MupcKgXxjb6C1hvGqBe5sYpXyxnj4d+REDDxJHCTGHQN5T43WjsE=
Message-ID: <9e4733910511230913y7fe5f9cfw99bfbb077ea9c87a@mail.gmail.com>
Date: Wed, 23 Nov 2005 12:13:06 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: Christmas list for the kernel
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, rmk+lkml@arm.linux.org.uk
In-Reply-To: <20051123170508.GE6970@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
	 <20051123150349.GA15449@flint.arm.linux.org.uk>
	 <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com>
	 <20051123155650.GB6970@stiffy.osknowledge.org>
	 <20051123160520.GH15449@flint.arm.linux.org.uk>
	 <9e4733910511230837v1519d3b3t28176b1fd6017ffc@mail.gmail.com>
	 <20051123164907.GA2981@ucw.cz>
	 <9e4733910511230859y3879e65fp927a7aa4d71d8fee@mail.gmail.com>
	 <20051123170508.GE6970@stiffy.osknowledge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Marc Koschewski <marc@osknowledge.org> wrote:
> * Jon Smirl <jonsmirl@gmail.com> [2005-11-23 11:59:27 -0500]:
> > Another would be to have a little user space daemon that listened to
> > the pty creation, and then mknod the tty nodes as need and pipe the
> > data through. That would be a first step to moving to a user space
> > console implementation.
>
> Shouldn't this be udev then? I hear people scream when 'some deamon'
> created a device in /dev. Was it udev? Was is 'ttydevd'? Even
> 'ondemanddevd'?

udev listens to /sys/class for it's indications on when to create a node.

The tty daemon would need to listen for pty creation to tell it when
to create a node. Then after it creates the node it needs to maintain
a pipe between the pty and tty. This is a lot different than what udev
does.

--
Jon Smirl
jonsmirl@gmail.com
