Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWCaA6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWCaA6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWCaA6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:58:24 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:8107 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S1751104AbWCaA6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:58:23 -0500
Message-ID: <442C7E9D.80800@namesys.com>
Date: Thu, 30 Mar 2006 16:58:05 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Mueller <robm@fastmail.fm>
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Oleg Drokin <green@linuxhacker.ru>, Chris Mason <mason@suse.com>,
       Bron Gondwana <brong@fastmail.fm>, Jeremy Howard <jhoward@fastmail.fm>
Subject: Re: System lockup with processes in D state in 2.6.16.1
References: <13d501c6544b$23e023d0$c100a8c0@robm>
In-Reply-To: <13d501c6544b$23e023d0$c100a8c0@robm>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob.  If Chris does not resolve this for you, please ping me,
otherwise I will assume that as the persons most familiar he or Oleg
will be the best ones to resolve it.

Hans

Robert Mueller wrote:

> Some time ago, we were seeing a problem in the kernel in the reiserfs
> code where a lock inversion issue could cause processes to get stuck
> in D state, requiring a system reboot.
>
> http://marc.theaimsgroup.com/?t=108932517300001&r=1&w=2
>
> This link describes the actual call path that causes the problem.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109035413201491&w=2
>
> At the time, the solution we got was to add a patch the basically
> bypasses reiser_file_write and just calls generic_file_write. This
> semed to fix the problem and we've been running for over a year fine
> with that patch.
>
> Recent we brought the issue up again with some reiser people, who
> mentioned that:
>
>> There was a patch for the problem referenced by this link. (By Cris
>> Mason,
>> I think). This patch is long included into vanilla kernel
>> (2.6.15 certainly contains it). If you still see deadlocks, I guess
>> you need
>> to gather some more info again (sysrq-t and friends).
>
>
> So we recently built 2.6.16.1, without the patch. However after just 1
> hour of stress testing with cyrus again, we were able to lock up the
> system with lots of processes stuck in D state and a load running to
> 500+. The machine had about 1500 processes running on it, and the
> dmesg buffer was only 1M, so it seems we weren't able to capture all
> the traces with a sysrq-t, but there's still a lot of info. I've put
> the sysrq-t and kernel config output at the links below:
>
> http://kernel.robm.fastmail.fm/sysrq-t-2006-03-30-1.txt
> http://kernel.robm.fastmail.fm/kernel-config-2006-03-30-1.txt
>
> Any idea if this is related to the previous problem or is something
> different?
>
> Rob
>
>
>
>

