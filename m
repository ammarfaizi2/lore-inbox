Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268186AbUHYS2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268186AbUHYS2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUHYS2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:28:48 -0400
Received: from mail.tmr.com ([216.238.38.203]:49669 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268186AbUHYS2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:28:45 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Wed, 25 Aug 2004 14:29:18 -0400
Organization: TMR Associates, Inc
Message-ID: <cgilcs$21o$1@gatekeeper.tmr.com>
References: <200408232101.i7NL1c26024662@falcon10.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093458141 2104 192.168.12.100 (25 Aug 2004 18:22:21 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <200408232101.i7NL1c26024662@falcon10.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Maxey wrote:
> On Mon, 23 Aug 2004 16:25:17 EDT, Bill Davidsen wrote:
> 
>>permission to open. This allows the admin to put in any filter desired,
>>know about vendor commands, etc. It also allows various security
>>setups,  the group can be on the user (trusted users) or on a setgid
>>program  (which limits the security issues).
> 
> 
>   Down such path lies madness :)   This list would have to be maintained for
>   most every model, of every drive, for every manufacturer.  The list could
>   conceivably change weekly, if not sooner.  This could change, of course, if
>   the use of linux would become as ubiquitous as the dominant redmond produnt, 
>   and the manufacturers would supply the "mini-port" driver bits, as it were.
> 
>   The theory is wonderful.  Until there is enough "clout" to change the 
>   manufacturers participation, it is probably futile. :-/

But you don't need magic vendor commands to read and write disk (or 
tape), you can do it with the base commands defined in SCSI-II. You only 
need filter lists for special cases where (a) you really do want vendor 
commands and (b) there's some reason to allow this to normal users.

I doubt that you need magic for any of the other obvious devices like 
SCSI scanners, ZIP and LS120 drives using ATA access rather than 
ide-floppy or ide-scsi, etc. I could be wrong on scanners, the setup 
commands may be more dangerous than I think.

To write CD unfortunately does seem to take more than I want the average 
user to do.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
