Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWHFXgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWHFXgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWHFXgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:36:25 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:52692 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1750754AbWHFXgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:36:24 -0400
Message-ID: <44D67CF6.3010905@slaphack.com>
Date: Sun, 06 Aug 2006 19:36:22 -0400
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Bernd Schubert <bernd-schubert@gmx.de>, reiserfs-list@namesys.com,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Clay Barnes <clay.barnes@gmail.com>,
       Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <44CF87E6.1050004@slaphack.com> <20060806225912.GC4205@ucw.cz>
In-Reply-To: <20060806225912.GC4205@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Tue 01-08-06 11:57:10, David Masover wrote:
>> Horst H. von Brand wrote:
>>> Bernd Schubert <bernd-schubert@gmx.de> wrote:
>>>> While filesystem speed is nice, it also would be great 
>>>> if reiser4.x would be very robust against any kind of 
>>>> hardware failures.
>>> Can't have both.
>> Why not?  I mean, other than TANSTAAFL, is there a 
>> technical reason for them being mutually exclusive?  I 
>> suspect it's more "we haven't found a way yet..."
> 
> What does the acronym mean?

There Ain't No Such Thing As A Free Lunch.

> Yes, I'm afraid redundancy/checksums kill write speed, and you need
> that for robustness...

Not necessarily -- if you do it on flush, and store it near the data it 
relates to, you can expect a similar impact to compression, except that 
due to slow disks, the compression can actually speed things up 2x, 
whereas checksums should be some insignificant amount slower than 1x.

Redundancy, sure, but checksums should be easy, and I don't see what 
robustness (abilities of fsck) has to do with it.

> You could have filesystem that can be tuned for reliability and tuned
> for speed... but you can't have both in one filesystem instance.

That's an example of TANSTAAFL, if it's true.
