Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWIJX7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWIJX7l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 19:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWIJX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 19:59:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12977 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964830AbWIJX7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 19:59:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       linux-usb-devel@lists.sourceforge.net,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] usb: Fixup usb so it uses struct pid
References: <m1hczgfi3h.fsf@ebiederm.dsl.xmission.com>
	<20060910213746.GA9565@kroah.com>
Date: Sun, 10 Sep 2006 17:58:33 -0600
In-Reply-To: <20060910213746.GA9565@kroah.com> (Greg KH's message of "Sun, 10
	Sep 2006 14:37:46 -0700")
Message-ID: <m1fyezclzq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Sat, Sep 09, 2006 at 10:42:10PM -0600, Eric W. Biederman wrote:
>> 
>> The problem by remember a user space process by it's pid it is
>> possible that the process will exit, pid wrap around will occur and a
>> different process will appear in it's place.  Holding a reference
>> to a struct pid avoid that problem, and paves the way
>> for implementing a pid namespace.
>> 
>> Also since usb is the only user of kill_proc_info_as_uid
>> rename kill_proc_info_as_uid to kill_pid_info_as_uid
>> and have the new version take a struct pid.
>> 
>> This patch is against 2.6.18-rc6-mm1.
>> 
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> Looks good to me.
>
> Do you want me to take this in my tree, or will you be going through
> Andrew, like your other, related pid stuff?  If through Andrew, please
> feel free to add:
> 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Sure.  I think going through Andrew makes sense.  As I probably have
a helper function or two in Andrews tree that hasn't hit wider distribution.

Eric
