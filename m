Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUDTANU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUDTANU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUDTANU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:13:20 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:33931 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262035AbUDTANS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:13:18 -0400
Message-ID: <40846B1B.2010103@yahoo.com.au>
Date: Tue, 20 Apr 2004 10:13:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Antti Lankila <alankila@elma.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: elevator=as, or actually gpm doesn't get time from scheduler???
References: <Pine.A41.4.58.0404191609060.42820@tokka.elma.fi>
In-Reply-To: <Pine.A41.4.58.0404191609060.42820@tokka.elma.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antti Lankila wrote:

> My X reads gpmdata, so perhaps that's the problem? I now undercut gpm in
> order to examine the situation, and my system behaves _perfectly_ as far as
> I can see. The mouse issues are all gone. (gpm is still running in the
> background, X just reads psaux directly. As I have understood, this is
> possible in 2.6 while in 2.4 it caused a problem for multiple readers.)
> 
> I progress from now by removing gpm on all my systems.  There's still the
> issue what gpm (or maybe kernel's scheduler) is doing wrong, I suppose.
> Nevertheless, gpm is virtually useless for me and has so far caused far more
> grief than its utility has ever been worth.
> 
> I'm sorry for having wasted your time with this.
> 

Not at all, thank you for reporting the problem.

It seems the CPU scheduler is a bit fragile when there
are a number of interrelated processes. Note: I don't
know whether my scheduler fixes this case or not, it might
just be a difficult problem.
