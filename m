Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTEAV5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 17:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTEAV5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 17:57:23 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:56240 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262706AbTEAV5W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 17:57:22 -0400
Date: Thu, 01 May 2003 18:07:59 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Swap Compression
In-reply-to: <20030430125913.GA21016@wohnheim.fh-wedel.de>
To: =?UNKNOWN?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200305011807590220.00677F96@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <200304292114.h3TLEHBu003733@81-2-122-30.bradfords.org.uk>
 <200304292059150060.002E747A@smtp.comcast.net>
 <200304301248.07777.kernel@kolivas.org>
 <20030430125913.GA21016@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Actually, I'd like a central compression library with a large
>assortment of algorithms. That way the really common code is shared
>between both (or more) projects is shared.
>
>Also, yet another unused compression algorithm hurts about as bad, as
>yet another unused device driver. It just grows the kernel .tar.bz2.
>
>Jörn


Had a thought.  Why wait for a compression algorithm?  Jorn, if you are going
to work on putting the code into the kernel and making the stuff to allow the
swap code to use it, why not start coding it before the compression code is
finished?  i.e. get the stuff down for the swap filtering (filtering i.e. passing
through a compression or encryption routine) and swap-on-ram stuff, and later
take the compression algo code and place the module interface on it and make
a kernel module.

At this point, I'd say to allow specified order filters, to allow for swap cyphering
and compression.  Security, you know; swap files are a security hazard.  Just
power-off, boot a root disk, pull up the swap partition, rip out the blocks, and
look for what looks to be the root password.

--Bluefox Icy

