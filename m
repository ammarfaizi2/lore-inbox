Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbULPXjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbULPXjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbULPXjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:39:15 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:29060 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S262192AbULPXjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:39:10 -0500
Date: Fri, 17 Dec 2004 00:39:00 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Greg KH <greg@kroah.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
In-Reply-To: <20041216225323.GA10616@kroah.com>
Message-ID: <Pine.LNX.4.60.0412170033160.25628@alpha.polcom.net>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com>
 <41C20356.4010900@sun.com> <20041216221843.GA10172@kroah.com>
 <20041216144531.3a8d988c@lembas.zaitcev.lan> <20041216225323.GA10616@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004, Greg KH wrote:

> On Thu, Dec 16, 2004 at 02:45:31PM -0800, Pete Zaitcev wrote:
>> On Thu, 16 Dec 2004 14:18:43 -0800, Greg KH <greg@kroah.com> wrote:
>>
>>> Hm, what about /.debug ?  That's a compromise that I can live with (even
>>> less key strokes to get to...)
>>
>> No way, Jan is out of his mind, adding obfuscations like that. Anything
>> but that. I didn't even bother to reply, because it never occurred to me
>> that you'd fall for something so retarded.
>
> Bah, fine :)
>
>> Otherwise, /dbg sounds good.
>
> Ok, I can live with that.

I agree that anything like /.* is broken and strange... But this is only 
my little opinion. :-)

But why creating dir in /proc - like /proc/debug is bad? Its advantages:
- it does not pollute namespace,
- it can be created by kernel at startup even on systems where debugfs 
will not be used (why not?),
- /proc is mounted in all configurations and often it is the first thing 
that startscripts do,
- if somebody really needs to debug proc using debugfs he can always mount 
it as /debug temporaily.


Thanks,

Grzegorz Kulewski

