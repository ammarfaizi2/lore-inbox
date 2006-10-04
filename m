Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWJDUpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWJDUpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWJDUpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:45:18 -0400
Received: from gw.goop.org ([64.81.55.164]:51162 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751104AbWJDUpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:45:17 -0400
Message-ID: <45241D56.8090402@goop.org>
Date: Wed, 04 Oct 2006 13:45:10 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: removed sysctl system call - documentation and timeline
References: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
In-Reply-To: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> ohhh, and correct the help text; it currently says
> "...Nothing has been using the binary sysctl interface for some time
> now so nothing should break if you disable sysctl syscall support" -
> that's obviously false as demonstrated by the above extract from my
> dmesg...
>

It's half true.  It's true that things try to use it, but they'll 
happily fall back to something else (/proc?) if it doesn't work.  I used 
to get those messages, but it appears that recent glibcs don't use it at 
all.

    J
