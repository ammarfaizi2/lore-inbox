Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWGOSu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWGOSu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 14:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWGOSuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 14:50:55 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:37270 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1030208AbWGOSuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 14:50:55 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Linux 2.6.17.5
Date: Sat, 15 Jul 2006 18:50:53 +0000 (UTC)
Organization: Cistron
Message-ID: <e9bded$qco$1@news.cistron.nl>
References: <20060715030047.GC11167@kroah.com> <Pine.LNX.4.64.0607142217020.5623@g5.osdl.org> <44B8A720.3030309@gentoo.org> <44B90DF1.8070400@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1152989453 27032 194.109.0.112 (15 Jul 2006 18:50:53 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <44B90DF1.8070400@ns666.com>,
Von Wolher  <trilight@ns666.com> wrote:
>Daniel Drake wrote:
>> Hi Linus,
>> 
>> Linus Torvalds wrote:
>> 
>>> I did a slight modification of the patch I committed initially, in the
>>> face of the report from Marcel that the initial sledge-hammer approach
>>> broke his hald setup.
>>>
>>> See commit 9ee8ab9fbf21e6b87ad227cd46c0a4be41ab749b: "Relax /proc fix
>>> a bit", which should still fix the bug (can somebody verify? I'm 100%
>>> sure, but still..), but is pretty much guaranteed to not have any
>>> secondary side effects.
>>>
>>> It still leaves the whole issue of whether /proc should honor chmod AT
>>> ALL open, and I'd love to close that one, but from a "minimal fix"
>>> standpoint, I think it's a reasonable (and simple) patch.
>>>
>>> Marcel, can you check current git?
>> 
>> 
>> I can confirm that the new fix prevents the exploit from working, with
>> no immediately visible side effects.
>> 
>> Thanks,
>> Daniel
>> 
>
>Can some one release a 2.6.17.6 ? I think many people are waiting at
>their keyboard to get their systems protected.

# mount -o remount,nosuid /proc

Haven't tested it but that should be the workaround.

Mike.

