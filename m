Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSGBIOT>; Tue, 2 Jul 2002 04:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSGBIOS>; Tue, 2 Jul 2002 04:14:18 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:30725 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316674AbSGBIOR>; Tue, 2 Jul 2002 04:14:17 -0400
Message-ID: <3D216157.FC60B17E@aitel.hist.no>
Date: Tue, 02 Jul 2002 10:16:23 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.24-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@mwaikambo.name>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
References: <Pine.LNX.4.44.0207011758180.3104-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> On Mon, 1 Jul 2002, Roy Sigurd Karlsbakk wrote:
> 
> > LABEL=/                 /                       ext3    defaults        1 1
> > /dev/md2                /tmp                    ext3    defaults        1 2
> > /dev/md3                /var                    jfs     defaults        1 2
> > /dev/md4                /data                   jfs     defaults        1 2
> > /dev/md1                swap                    swap    defaults        0 0
> 
> One small thing, you do know that you can interleave swap?

There are sometimes reasons not to do that.
Heavy swapping may be caused by attempts to cache 
massive io on some fs.  You better not have swap
on that heavily accessed spindle - because then
everything ends up waiting on that io.

Keeping swap somewhere else means other programs
just wait a little for swap - undisturbed by the massive
io also going on.

Helge Hafting
