Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131092AbRCMPlR>; Tue, 13 Mar 2001 10:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131128AbRCMPlH>; Tue, 13 Mar 2001 10:41:07 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:11829 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S131092AbRCMPlB>; Tue, 13 Mar 2001 10:41:01 -0500
Date: Tue, 13 Mar 2001 17:40:15 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdfs
Message-ID: <20010313174015.C5316@niksula.cs.hut.fi>
In-Reply-To: <20010313162341.C1311@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010313162341.C1311@werewolf.able.es>; from jamagallon@able.es on Tue, Mar 13, 2001 at 04:23:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 04:23:41PM +0100, you [J . A . Magallon] claimed:
> Hi, 
> 
> Recently I read the BeOS www page, and answerd a question in other mailing
> list. Both things have remind me of a pretty file system: 'cdfs'.
> 
> Anybody knows if there is a port of 'cdfs' (Audio CD File System) for Linux ?
> Which fs now in kernel would be good as a template to start ?
> I am always looking for something enough easy to start kernel programming,
> and this could be a nice start (look, throw away all your ripping soft
> and just do a 'cp').

Below is one response to a similar question from the l-k archive:

From: David Balazic <david.balazic@uni-mb.si>
Date: Thu, 13 Jan 2000 12:08:39 -0800 
Subject: Re: CD-ROM Driver Design

There are already two file-systems for CD-audio on Linux :
- cdfs at
http://www.elis.rug.ac.be/~ronsse/cdfs/
- audiofs at
http://fly.cc.fer.hr/~ptolomei/audiofs/

Are you sure there is a need for a third one ? The audiofs uses the
CDROMREADAUDIO for reading the data and uses the page-cache for caching. I
personally added the page-cache code , but I don't believe it makes a lot
of sense, because when ripping audio, you read data sequentially , so the
cache just eats all free RAM ( possibly throwing out other more usefull
cached data ) and gives almost no gain. By the way , when there is a
"normal" FS on a "normal" block device, does the data get cached twice,
once in buffer-cache and once in page-cache ?
David Balazic


-- v --

v@iki.fi
