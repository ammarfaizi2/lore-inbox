Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVBOVU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVBOVU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVBOVU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:20:28 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:31393 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261891AbVBOVUW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:20:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Ieq23wBPFIh4nuyUJ6QVI+zL4axuwGQOQRlEAXvT8gTOIT0RfvSYSstLrbG227E16B/GPbbdSvNExfFZxZwcA61qNgBPGklSNGM9BNSBIlC7wxj9hsRuc5u/pDdz3e5yK2RjkE5zyN0uylqV+Dju6qkbbrVxI3Mb5v5QunRPR3w=
Date: Tue, 15 Feb 2005 22:02:54 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: prakashp@arcor.de, paolo.ciarrocchi@gmail.com, gregkh@suse.de,
       pmcfarland@downeast.net, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-Id: <20050215220254.511a6001.diegocg@gmail.com>
In-Reply-To: <1108497066.7826.33.camel@krustophenia.net>
References: <20050211004033.GA26624@suse.de>
	<420C054B.1070502@downeast.net>
	<20050211011609.GA27176@suse.de>
	<1108354011.25912.43.camel@krustophenia.net>
	<4d8e3fd305021400323fa01fff@mail.gmail.com>
	<42106685.40307@arcor.de>
	<1108422240.28902.11.camel@krustophenia.net>
	<20050215004329.5b96b5a1.diegocg@gmail.com>
	<1108497066.7826.33.camel@krustophenia.net>
X-Mailer: Sylpheed version 1.9.2+svn (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 15 Feb 2005 14:51:06 -0500,
Lee Revell <rlrevell@joe-job.com> escribió:


> Of course resuming from suspend will always be faster than booting but
> for the forseeable future we will have to reboot from time to time.  And
> XP's boot time currently is way, way better than ours.  FWIW, OSX still
> takes forever to boot so we are not the only ones with this problem.


What I wonder is if we can have a "process-to-disk" thing and use it to improve
other things. Some OSs implement this (DFbsd, for one), but I think we could
use it to do some cool things, ie: instead of closing gnome and restarting all
the apps when you login again, you could do something like "when you're
closing gnome, dump all the process' images to disk and restart all the process
when you login again". This way your desktop would be *always* in the
same state you left it (including things like the text buffer in your terminal). You
could use it to speed up some things ej: instead of loading openoffice, load a saved
image of a void document. Of course there're lots of problems, like what happens
if you change a file which was being used by a suspended process, disconnection
between app <-> xserver (x folks are working on thinks like that because of wireless
connections i think) , what happens if you update a library that a image is supposed to
use, can users "restart" images or just only root, etc but i think it'd be interesting to
discuss if it's feasible

(in the X world there's already some "signal" sent to programs, but if we were able
to do it by "sending a process' image to disk" it'd be much easier and cleaner IMHO)
