Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268861AbUHLWhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268861AbUHLWhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268872AbUHLWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:37:17 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:14468 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268861AbUHLWhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:37:01 -0400
Message-ID: <411BF1E6.5060309@tmr.com>
Date: Thu, 12 Aug 2004 18:40:38 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <1092124796.1438.3695.camel@imladris.demon.co.uk> <yw1x7js79vn3.fsf@kth.se>
In-Reply-To: <yw1x7js79vn3.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> David Woodhouse <dwmw2@infradead.org> writes:

>>That seems reasonable, but _only_ if burnfree is not enabled. If the
>>hardware _supports_ burnfree but it's disabled, the warning should also
>>recommend turning it on.
> 
> 
> I'm also wondering why cdrecord disables it by default.  Can it ever
> do any harm being enabled?
> 

In theory, yes. It makes the track longer, so it could in theory make 
something large not fit. In practice, there really are some readers 
which skip on audio when they see the blanks. As Joerg which ones, but 
other people have agreed that it does happen.

I have noted that even with it off my recent burners don't mind running 
out of data, so in most cases it won't hurt. Burning off NFS I see 7-10 
underruns typically.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
