Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVALQ6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVALQ6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVALQ6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:58:05 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:26028 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261255AbVALQ6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:58:01 -0500
Message-ID: <41E557BC.9010405@tmr.com>
Date: Wed, 12 Jan 2005 12:00:44 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Sanders <sandersn@btinternet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs
References: <1105474144.15542.1.camel@zeus.city.tvnet.hu><1105474144.15542.1.camel@zeus.city.tvnet.hu> <200501112151.13351.sandersn@btinternet.com>
In-Reply-To: <200501112151.13351.sandersn@btinternet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Sanders wrote:
> On Tuesday 11 January 2005 20:09, Sipos Ferenc wrote:
> 
>>Hi!
>>
>>For me, dvd writing works only when I run growisofs with root
>>permissions (using 2.6.10 kernel, /dev/hdc without ide-scsi)
>>
> 
> 
> For me when running growisofs  with user permissions on 2.6.10 (ide-cd) it 
> works perfectly 1st time but 2nd time fails with the error below. It works 
> fine when run as root.
> 
> :-( unable to PREVENT MEDIA REMOVAL: Operation not permitted
> 
> As an aside audio cd burning with cdrecord works as long as the '-text' option 
> isn't used, if it is the process hangs.

I reported a similar thing with cdrecord, writing a first session 
successfully using the -multi flag, but not being able to append to it 
or read the size with the "-msinfo" flag. I was totally blown off and 
told I didn't have permissions on the device, even though I was able to 
write to it.

I believe the true answer is that the SCSI command filter is blocking a 
command needed to perform the operation, probably a command to lock the 
door of the drive. In my case I have permissions to write the CD, just 
not to read the info needed to write additional sessions.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
