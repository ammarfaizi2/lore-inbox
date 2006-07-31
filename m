Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWGaVQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWGaVQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWGaVQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:16:42 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:1430 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751330AbWGaVQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:16:41 -0400
Message-ID: <44CE7335.4080101@slaphack.com>
Date: Mon, 31 Jul 2006 16:16:37 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Clay Barnes <clay.barnes@gmail.com>, Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by  kernelnewbies.orgregarding
 reiser4 inclusion
References: <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>  <20060731125846.aafa9c7c.reiser4@blinkenlights.ch>  <20060731144736.GA1389@merlin.emma.line.org>  <20060731175958.1626513b.reiser4@blinkenlights.ch>  <20060731162224.GJ31121@lug-owl.de>  <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>  <20060731173239.GO31121@lug-owl.de>  <20060731181120.GA9667@merlin.emma.line.org>  <20060731184314.GQ31121@lug-owl.de>  <20060731191712.GE17206@HAL_5000D.tc.ph.cox.net>  <20060731192902.GS31121@lug-owl.de> <44CE6153.7090704@slaphack.com> <Pine.LNX.4.63.0607311348150.14631@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0607311348150.14631@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Mon, 31 Jul 2006, David Masover wrote:
> 
>> Probably.  By the time a few KB of metadata are corrupted, I'm 
>> reaching for my backup.  I don't care what filesystem it is or how 
>> easy it is to edit the on-disk structures.
>>
>> This isn't to say that having robust on-disk structures isn't a good 
>> thing. I have no idea how Reiser4 will hold up either way.  But 
>> ultimately, what you want is the journaling (so power failure / 
>> crashes still leave you in an OK state), backups (so when blocks go 
>> bad, you don't care), and performance (so you can spend less money on 
>> hardware and more money on backup hardware).
> 
> please read the discussion that took place at the filesystem summit a 
> couple weeks ago (available on lwn.net)

I think I will, but I don't have the time today, so...

> one of the things that they pointed out there is that as disks get 
> larger the ratio of bad spots per Gig of storage is remaining about the 
> same. As is the rate of failures per Gig of storage.
> 
> As a result of this the idea of only running on perfect disks that never 
> have any failures is becomeing significantly less realistic, instead you 
> need to take measures to survive in the face of minor corruption 
> (including robust filesystems, raid, etc)

RAID seems a much more viable solution to me.  That and cheaper storage, 
so that you can actually afford to replace the disk when you find 
corruption, or have more redundancy so you don't have to.

Because "robust filesystems" is nice in theory, but in practice, you 
really never know what will get hit.  RAID, at least, is predictable.

When it's not:  Backups.
