Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVLXSy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVLXSy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 13:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVLXSy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 13:54:58 -0500
Received: from vena.lwn.net ([206.168.112.25]:56798 "HELO lwn.net")
	by vger.kernel.org with SMTP id S932307AbVLXSy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 13:54:58 -0500
Message-ID: <20051224185458.8571.qmail@lwn.net>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tape Drive Question (2.6.14.4) 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Sat, 24 Dec 2005 10:10:27 EST."
             <Pine.LNX.4.64.0512241009230.2904@p34> 
Date: Sat, 24 Dec 2005 11:54:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> $ ls -l /dev/st0*
> crw-rw-rw-  1 root tape 9,  0 2004-09-18 07:51 /dev/st0
> crw-rw-rw-  1 root tape 9, 96 2004-09-18 07:51 /dev/st0a
> crw-rw-rw-  1 root tape 9, 32 2004-09-18 07:51 /dev/st0l
> crw-rw-rw-  1 root tape 9, 64 2004-09-18 07:51 /dev/st0m
> 
> What differentiates st0 from a,l,m?
> What does writing or reading to a tape using a,l,m signify?

By default, they're all the same.  You can tweak the driver parameters,
however, to cause the different devices to use different densities and
blocking modes.  See mt(1) and Documentation/scsi/st.txt.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
