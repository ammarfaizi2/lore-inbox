Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTDIPnr (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbTDIPnr (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:43:47 -0400
Received: from host.atlantavirtual.com ([209.239.35.47]:11982 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S263528AbTDIPnq (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 11:43:46 -0400
Subject: Re: mounting partitions on loopback
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049907303.4504.46.camel@thong>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Apr 2003 12:55:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren

you'll have to either specify the offsets that the partitions start at
via;

mount -o ro,loop,offset=XXX  blah blah blah

Or, use a program such as SMART for Linux (asrdata.com) that will do
that for you and allow you to right-click on them (logical partitions)
and mount them.

Remember, though, if that start of the filesystem is beyond 2GB into the
image you'll not be able to mount it even specifying the offset.  (I
think this is a 'bug' with the loop driver that ships with kernel?)
However, NASA has come up with a nice workaround I use and you can find
it here;

ftp://ftp.hq.nasa.gov/pub/ig/ccd/enhanced_loopback/

This modified loopback driver will automatically mount the partitions
within that physical image file read only using the loop devices on your
system.  (no calculation of offsets is necessary, no problem if beyond
2GB, etc.).


hope this helps!

farmerdude




