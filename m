Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVBDKcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVBDKcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVBDKcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:32:06 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:3804 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261783AbVBDKbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:31:44 -0500
Message-ID: <42034F0E.5090109@cwazy.co.uk>
Date: Fri, 04 Feb 2005 05:31:42 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jerome lacoste <jerome.lacoste@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Huge unreliability - does Linux have something to do with it?
References: <5a2cf1f605020401037aa610b9@mail.gmail.com>
In-Reply-To: <5a2cf1f605020401037aa610b9@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [70.16.225.90] at Fri, 4 Feb 2005 04:31:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste wrote:
> [Sorry for the sensational title]
> 
> I have had this laptop for three years. It ran Linux (Debian unstable)
> from the start and its hardware has been very unreliable: I changed
> hard disks twice and the motherboard thrice. My DVD drive started
> failing some days ago (this one is 'original', 3 years old). But I
> don't mind as I am not under warranty anymore... This morning the
> machine booted with fsck errors on my hard disk. I am not sure if I
> did the right thing, but I said clear the inodes, and I ended up
> loosing some programs(*) (du, dircolors, etc..). The day starts well
> isn't it? Sounds like I will have to switch disks again...
> 
> I halted the machine correctly yesterday night. I never dropped the
> box in 3 years. Am I just being unlucky? Or could the fact that I am
> using Linux on the box affect the reliability in some ways on that
> particular hardware (Dell Inspiron 8100)? I run Linux on 3 other
> computers and never had single problems with them.
> 
> How can the file system (ext3) be messed up the way it was this
> morning after I stopped the machine correctly yesterday?
> Could a hardware failure look like bad sectors to fsck?
> 

It can.  I had a drive crash on my server a couple of months ago, and I had ext3 
errors show up before the syslog filled up with the ide errors.  The hard disk was 
only 1 1/2 years old.

If the bad sectors happen where directory inodes are written, your directory 
structure will be turned into swiss cheese.  That will *definitely* cause ext3 
errors, and dump you (in Red Hat systems, at least) to a shell on reboot.

> Attached the output of smartctl -a /dev/hda, whatever that helps.
> 
> Jerome
> 
> (*) I accept tips on discovering and maybe recovering which files have
> been taken out of my system...
> 

You might not have any luck.  After fsck -f, I thought I had saved the drive, 
copied everything that was left onto another machine, and found that most of the 
larger files had holes in them - mp3's had skips, jpegs were completely corrupted, 
etc.

That's what made me get a backup FireWire drive... :)
