Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUJDTtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUJDTtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUJDTtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:49:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:60562 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268344AbUJDTr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:47:28 -0400
Message-ID: <4161A8F0.4040402@tmr.com>
Date: Mon, 04 Oct 2004 15:48:00 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Mike Mestnik <cheako911@yahoo.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Merging DRM and fbdev
References: <20041003183839.36810.qmail@web11903.mail.yahoo.com><9e4733910410030833e8a6683@mail.gmail.com> <9e47339104100311566f66eb43@mail.gmail.com>
In-Reply-To: <9e47339104100311566f66eb43@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On Sun, 3 Oct 2004 11:38:39 -0700 (PDT), Mike Mestnik
> <cheako911@yahoo.com> wrote:
> 
>>What about moving the DRM and FB specific code into there own per card
>>libs?
>>
>>radeon - attached to hardware
>>   radeon-drm
>>      drm - library
>>   radeon-fb
>>      fb - library
>>         fbcon - library
> 
> 
> Fell free to convert the merged radeon driver in to a driver plus two
> libs if you want. I'll accept the patch back. You'll need to wait
> until I get the merged driver working.
> 
> What I don't want is two independent implementations of the hardware
> initialization code like we currently have. The point of merging is to
> make sure that a single logical driver programs the hardware is a
> consistent way.
> 
> We spend so much time talking about splitting the radeon driver into
> pieces. But I don't hear anyone saying I can't ship my product because
> the radeon driver is 120K and all I can handle is 60K. I'm not going
> to spend a week's work breaking things up and testing them just
> because of some theoretical need for a non-existant embedded system.
> When this hypothetical embedded system shows up the people making the
> money off from the system can do the work.

Perhaps there might be some feedback from the embedded folks and/or 
those who decide if these changes are what they want to go in the 
kernel. If you're going to do something like this, one of the embedded 
vendors might want to contribute to development. Clearly smaller 
software parts have advantages, if resources were available to do it 
split as part of the modification.

That would probably reduce the maintenence effort in the future as well.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
