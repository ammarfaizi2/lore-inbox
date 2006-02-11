Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWBKBDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWBKBDb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 20:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWBKBDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 20:03:31 -0500
Received: from smtpout10-04.prod.mesa1.secureserver.net ([64.202.165.238]:15250
	"HELO smtpout10-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1751209AbWBKBDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 20:03:31 -0500
Message-ID: <43ED37E2.3060800@hackmiester.com>
Date: Fri, 10 Feb 2006 19:03:30 -0600
From: "hackmiester (Hunter Fuller)" <hackmiester@hackmiester.com>
Reply-To: hackmiester@hackmiester.com
Organization: hackmiester.com, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re:
 CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring
 up a hornets' nest) ]]
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <20060210175848.GA5533@stiffy.osknowledge.org> <43ECE734.5010907@cfl.rr.com> <20060210210006.GA5585@stiffy.osknowledge.org>
In-Reply-To: <20060210210006.GA5585@stiffy.osknowledge.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm. ssh into the box and then try to blank the CD on the local machine. 
Is the ssh session still responsive? I suspect it will be, especially if 
the GNOME clock's still running.
-- 
--hackmiester
Walk a mile in my shoes and you will be a mile away in a new pair of shoes.


Marc Koschewski wrote:
> * Phillip Susi <psusi@cfl.rr.com> [2006-02-10 14:19:16 -0500]:
> 
> 
>>Marc Koschewski wrote:
>>
>>>I just tried blanking a CD-RW with the latest -git tree. The machine just 
>>>became
>>>unresponsive and then froze. When it became unresponsive the clock in 
>>>GNOME still
>>>displayed the current time but I could not focus any windows anymore. Then 
>>>I had
>>>to hard reboot the machine. The logs say nothing. I repeat: nothing.
>>>
>>>Does anyone have similar problems?
>>
>>Instead of rebooting, just wait for the blanking to finish.  My guess is 
>>that your burner and hard drive are both on the same ide channel, and so 
>>you can not access the disk while the burner is blanking.  If this is 
>>the case, put each drive on their own ide channel. 
> 
> 
> I've been waiting 30 minutes for the machine to come back but no chance. SSH
> didn't work either. I thought I could login remote... but uh uh.
> 
> The problem is, it's a laptop. So there not much chance to move the cdrom device
> over to another controller or whatever. ;)
> 
> But let's face it: is it really crappy to render a laptop unusable just because
> blanking a CD-RW. The circumstances were: run xcdroast via gksu (thus running as
> root), blank CD-RW. Due to cd-burning being totally unusable as a user (problems
> here and there if it was just doing anything at all). So I've no other chance
> than to run this as root. Couldn't cdrecord 'watch' ide load or - even better -
> forcecast it? It knows blanking leads to inresponsiveness sometimes (even more due
> to the fact that both devices share the same bus). Why not kind of  'renice'
> the process that blanks?
> 
> Marc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
