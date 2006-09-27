Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWI0NFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWI0NFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 09:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWI0NFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 09:05:34 -0400
Received: from main.gmane.org ([80.91.229.2]:9868 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750701AbWI0NFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 09:05:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Robert <kerplop@sbcglobal.net>
Subject: Re: A little script help please .... USB Keychain Drives
Date: Wed, 27 Sep 2006 07:55:26 -0500
Message-ID: <efdsbv$t5l$1@sea.gmane.org>
References: <14CFC56C96D8554AA0B8969DB825FEA001C397FA@chicken.machinevisionproducts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-209-30-178-82.dsl.rcsntx.swbell.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060915 CentOS/1.0.5-0.1.el4.centos4 SeaMonkey/1.0.5
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA001C397FA@chicken.machinevisionproducts.com>
Cc: fedora-list@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian D. McGrew wrote:
> Can someone who is a little better at scripting than I give me some help
> here on Fedora Core 3.
> 
> Using the 2.6.9 kernel I would put in a USB Keychain drive of a CD-ROM
> and it would automount it without a problem.
> 
> We upgrade to 2.6.16.16 and this is now broken and thanks to the list,
> we've narrowed it to the haldaemon but because of production cycles I
> can't upgrade anything.  I'm stuck with what I've got.
> 
> Can someone share a script that I can run with a setuid bit to find and
> mount the CD-ROM _and_ the USB Keychain drive after they're inserted?  I
> can't see to get anything to work properly.
> 
> Thanks,
> 
> :b!
> 
> Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
> --
>> This is a test.  This is only a test!
>   Had this been an actual emergency, you would have been
>   told to cancel this test and seek professional assistance!
> 
> 

ASSUMING a mount point gets created when you plug in that USB drive, you 
might do something similar to what I did in my backup script:

# Set the output mount (UD is USB DRIVE mount point)
export UD=/media/OTOT
#
#
# Check for drive mounted
if [ -z  $(mount | grep $UD | awk '{ print $3 }') ]; then
    mount $UD
fi
#
#
The key is having the mount point automatically created. Check 
/etc/fstab with the drive plugged in and go from there. 

