Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWGEMVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWGEMVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 08:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWGEMVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 08:21:42 -0400
Received: from mail.tmr.com ([64.65.253.246]:39399 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S964836AbWGEMVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 08:21:42 -0400
Message-ID: <44ABAF7D.8010200@tmr.com>
Date: Wed, 05 Jul 2006 08:24:29 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060704010240.GD6317@thunk.org>
In-Reply-To: <20060704010240.GD6317@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Sat, Jul 01, 2006 at 06:33:01PM +0200, Thomas Glanzmann wrote:
>> I would like to know which new features are planed to be incorported by
>> ext4. So far I only read about supporting bigger filesystems to fit
>> recent hardware developments. So are there any other big goals for ext4?
> 
> Some of the ideas which have been tossed about include:
> 
> 	* nanosecond timestamps, and support for time beyond the 2038

The 2nd one is probably more urgent than the first. I can see a general 
benefit from timestamp in ms, beyond that seems to be a specialty 
requirement best provided at the application level rather than the bits 
of a trillion inodes which need no such thing.

One argument against it is that with SMP with *almost* the same time in 
each CPU, cache everywhere in the i/o process, and various flavors of 
network filesystems, the atime/mtime become less and less useful for 
determining with great precision which file is most recently modified or 
accessed.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

