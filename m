Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTESQcv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTESQcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:32:51 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:17161 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261754AbTESQct convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:32:49 -0400
From: Steve Brueggeman <xioborg@yahoo.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] submount: another removeable media handler
Date: Mon, 19 May 2003 11:45:46 -0500
Message-ID: <oc2icvot0lp3qaqpven4v7bgp6e7oc6krm@4ax.com>
References: <200305160106.37274.eweiss@sbcglobal.net> <20030516113304.GK32559@Synopsys.COM> <200305161027.20045.eweiss@sbcglobal.net> <ba3bls$c2p$1@cesium.transmeta.com>
In-Reply-To: <ba3bls$c2p$1@cesium.transmeta.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Off Topic, sorry.

Is there a way to detect whether a floppy has been installed, without
actually forcing the motor to spin, and heads to engage???

I'd like to create a simple auto-run utility that constantly looks for
a special file on a MSDOS formatted floppy, and run it if found.
Unfortunately, the only way I know of to determine if a floppy is
installed is to open the floppy device, which causes the undesired
motor spin-up, and head access.

Any help is greatly appreciated!!!

Steve Brueggeman


On 16 May 2003 11:46:20 -0700, you wrote:

>Followup to:  <200305161027.20045.eweiss@sbcglobal.net>
>By author:    Eugene Weiss <eweiss@sbcglobal.net>
>In newsgroup: linux.dev.kernel
>>
>> 
>> > how is it different from what automounter does?
>> 
>> Autofs works by creating a special filesystem above the vfs layer, and passing 
>> requests and data back and forth.   Submount actually does much less than 
>> this- it puts a special filesystem underneath the real one, and the only 
>> things it returns to the VFS layer are error messages.  It handles no IO 
>> operations whatsoever.
>> 
>> Peter Anvin has called using the automounter for removeable media "abuse."
>> Submount is designed for it.
>> 
>
>Sure, but it's not clear to me that you have listened to me saying
>*why* it is abuse.
>
>Basically, in my opinion removable media should be handled by insert
>and removal detection, not by access detection.  Obviously, there are
>some sticky issues with that in the case where media can be removed
>without notice (like PC floppies or other manual-eject devices), but
>overall I think that is the correct approach.
>
>	-hpa

