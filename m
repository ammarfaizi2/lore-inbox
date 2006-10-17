Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423000AbWJQCrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423000AbWJQCrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 22:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423003AbWJQCrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 22:47:12 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:14713 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1423000AbWJQCrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 22:47:10 -0400
Date: Mon, 16 Oct 2006 22:47:09 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: raw1394 problems galore
In-reply-to: <200610161921.22847.dan@dennedy.org>
To: Dan Dennedy <dan@dennedy.org>
Cc: linux1394-user@lists.sourceforge.net,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       For users of Fedora Core releases 
	<fedora-list@redhat.com>,
       linux-kernel@vger.kernel.org
Message-id: <4534442D.8010200@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <4532DF11.9060704@verizon.net> <4533DDA2.2050008@verizon.net>
 <4533FBD8.7050101@s5r6.in-berlin.de> <200610161921.22847.dan@dennedy.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Dennedy wrote:
> On Monday 16 October 2006 2:38 pm, Stefan Richter wrote:
>> Gene Heskett wrote:
>>> kino-0.8 receives video from it in real time and is doing so right now,
>>> and can capture it to file, and then play/edit that file, or could
>>> saturday when I last tried it.  I ASSume that kino-0.9.2 could also
>>> play/edit that file, but have not verified that by reinstalling 0.9.2.
>> ...
>>> I was told it was a total rewrite of bad code when I complained about a
>>> year ago.  My reply at the time was that it worked, and I don't often
>>> fix things that are working.  I'm getting lazy in my dotage I guess.
>> I don't remember what was changed at that time. Maybe that was the
>> addition of the new isochronous interface that I mentioned. The old one
>> was (is?) still there but maybe there were interactions... 
> 
> Allow me to help clarify. There are 4 interfaces for capturing DV--I kid you 
> not! One is video1394, which Kino has never supported for capture. Kino 0.8.0 
> supports legacy raw1394 and dv1394 switchable via Preferences. Gene is using 
> the legacy raw1394 in that version, based upon a screenshot he sent. Kino 
> 0.9.2 supports dv1394 and libiec61883 (atop raw1394 rawiso) switchable ONLY 
> at build time requiring an explicit configure option for dv1394. This is to 
> coerce builders to the newest and best capture interface.
> 
>> However this  is not related to the inability to issue AV/C commands, which
>> are issued asynchronously.  
> 
> Correct; it is very curious that his device is not recognized via configROM 
> probes and does not respond to AV/C control commands. This now impacts Kino 
> 0.9.2 with libiec61883 (Gene's configuration) because I simplified the UI for 
> the typical case--the one where 1394 asynch works. In that case, the first 
> recognized camera during a bus traversal (or selectable via a simple pulldown 
> menu) lets Kino determine on which 1394 port this device sits in order to 
> make capture "just work." (permissions issues to /dev/raw1394 aside :-) It is 
> very rare that someone can capture but not have AV/C and device recognition. 
> The majority of problem reports are just the opposite with the majority 
> resolved by unloading eth1394!
> 
Let me append that with this kernel, gscanbus also works as expected, 
including controlling the camera.  Wahoo!

-- 
Cheers, Gene

