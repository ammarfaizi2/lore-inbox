Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbVFXIZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbVFXIZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbVFXIZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:25:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40358 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263211AbVFXIYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:24:14 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       David Lang <david.lang@digitalinsight.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [git patch] urgent e1000 fix 
In-reply-to: Your message of "Fri, 24 Jun 2005 09:49:05 +0300."
             <200506240949.05620.vda@ilport.com.ua> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Jun 2005 18:22:59 +1000
Message-ID: <13661.1119601379@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005 09:49:05 +0300, 
Denis Vlasenko <vda@ilport.com.ua> wrote:
>On Friday 24 June 2005 02:33, Linus Torvalds wrote:
>> To actually allow real fuzz or to allow real whitespace differences in the
>> patch data itself is a _much_ bigger issue than this trivial patch
>> corruption, and I'd prefer to avoid going there if at all possible.
>
>How about automatic stripping of _trailing_ whitespace on all incoming
>patches? IIRC no file type (C, sh, Makefile, you name it) depends on
>conservation of it, thus it's 100% safe.

One (admittedly rare) case - adding a text file that contains an
embedded patch, so you have a patch that includes a patch.  This is
sometimes done in Documentation files when an external file has to be
changed.  In embedded patch, empty lines are converted to a single
space, which then appears as trailing whitespace.  Not sure if that is
a big enough reason not to strip whitespace.

