Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUCCMWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 07:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUCCMWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 07:22:44 -0500
Received: from mail.aei.ca ([206.123.6.14]:52960 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262450AbUCCMWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 07:22:42 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] udev 021 release
Date: Wed, 3 Mar 2004 07:22:17 -0500
User-Agent: KMail/1.5.93
Cc: Michael Weiser <michael@weiser.dinsnail.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net>
In-Reply-To: <20040303095615.GA89995@weiser.dinsnail.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403030722.17632.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 03, 2004 04:56 am, Michael Weiser wrote:
> Normally with static /dev one has a /dev/dsp device for example. As soon
> as an application tries to open it the kernel would try to load a module
> "sound" or "char-major-something" if sound support isn't compiled into
> it. Now with udev I'll never get /dev/dsp in the first place and there's
> no mechanism like devfs's file open monitoring and subsequent device
> file creation. So my idea is to initialise /dev with some static files,
> for hardware I know is there but hasn't had a driver loaded yet. My
> question is: Is there a nicer and more elegant way than just unpacking a
> tarball into /dev before starting udevd? A tarball would also break a
> (theoretical) use of dynamic major/minor numbers by the kernel.

Would it be possible to have something in the module itself?  i.e. We create
a new macro to add info that a script can use.  This info could live in a new file 
in lib/modules or in the actual module.  This could be used to create the static 
setup dynamicly.

This item keeps coming up as the one feature that devfs has and udev 
does not.  It keeps getting dismissed.  Users seem to actually want it...

Ed Tomlinson 

