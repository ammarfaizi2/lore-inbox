Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbUBPUdg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUBPUdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:33:36 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:56502 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S265901AbUBPUdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:33:12 -0500
Date: Mon, 16 Feb 2004 21:33:10 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040216203310.GF17015@schmorp.de>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
References: <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org> <20040216202142.GA5834@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216202142.GA5834@outpost.ds9a.nl>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 09:21:42PM +0100, bert hubert <ahu@ds9a.nl> wrote:
> The remaining zit is that all these represent '..':

No, they don't. Read the UTF-8 definition...

> This in itself is not a problem, the kernel will only recognize 2E 2E as the
> real .., but it does show that 'document.doc' might be encoded in a myriad
> ways.

No, it can only be encoded in exactly one way *in UTF-8*. It can of course
be encoded differently in other encodings, but in UTF-8, there is only a
single representation. There are no ambiguities.

> So some guidance about using only the simplest possible encoding might be
> sensible, if we don't want the kernel to know about utf-8.

Fortunately, this has all already been taken care of, and is not a problem.

I mean, the _definition_ of UTF-8 works. Wether specific applications
(wether in the kernel or apps) work is a different question. But at
least the specification is rather clear.

Compare this to the URL definition, which only hints that you don't know
the encoding, and therefore, the interpretation as text, of a URL unless
you have an extra channel that communicates it.

While possible, this channel does not exist in practise, creating big
problems for people writing i18n-ized web applications.

The thing is that the kernel certainly _works_ on a very basic level, but
I think the situaiton can be improved by making it clear how to interpret
filenames, which currently is not the case.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
