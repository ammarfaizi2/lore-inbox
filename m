Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTKLBSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 20:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTKLBSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 20:18:39 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:34253 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261311AbTKLBSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 20:18:38 -0500
Message-ID: <3FB18A69.6020104@cyberone.com.au>
Date: Wed, 12 Nov 2003 12:18:33 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Drake <dan@reactivated.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm2
References: <20031104225544.0773904f.akpm@osdl.org> <3FB11B93.60701@reactivated.net>
In-Reply-To: <3FB11B93.60701@reactivated.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Drake wrote:

> I've been getting a couple of audio skips with 2.6.0-test9-mm2. 
> Haven't heard a skip since test4 or so, so I'm assuming this is a 
> result of the IO scheduler tweaks.
>
> Here's how I can produce a skip:
> Running X, general usage (e.g. couple of xterms, an emacs, maybe a 
> mozilla-thunderbird)
> I switch to the first virtual console with Ctrl+Alt+F1. I then switch 
> back to X with Alt+F7. As X is redrawing the screen, the audio skips 
> once.
> This happens most of the time, but its easier to reproduce when i am 
> compiling something, and also when I cycle through the virtual 
> consoles before switching back to X.


Unlikely to be an IO scheduler change.

Switching from X to console or back can cause high CPU scheduling
latencies. I haven't tried to discover why.


