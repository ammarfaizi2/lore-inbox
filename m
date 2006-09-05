Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbWIEUtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWIEUtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWIEUtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:49:09 -0400
Received: from ns1.suse.de ([195.135.220.2]:42668 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422632AbWIEUtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:49:07 -0400
From: Andi Kleen <ak@suse.de>
To: "Kimball Murray" <kimball.murray@gmail.com>
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
Date: Tue, 5 Sep 2006 22:48:56 +0200
User-Agent: KMail/1.9.3
Cc: "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com> <1157478021.9036.29.camel@laptopd505.fenrus.org> <bbe04eb10609051138k4059c9e4yd1b4f693d77b3761@mail.gmail.com>
In-Reply-To: <bbe04eb10609051138k4059c9e4yd1b4f693d77b3761@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609052248.56838.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 September 2006 20:38, Kimball Murray wrote:

> As before, Stratus would not object to providing all kernel modules as
> GPL, but still our problem is that there is some code that reflects
> some of our chipset vendor's proprietary information, so they won't

Is that Intel? They normally don't have problems with free drivers.

> At 1400 lines, I should probably find a server to make this available.
>  But not having one at the moment, please forgive the attachment.

The code would certainly need a lot of cleanup and split up etc.
(Andrew has a nice document on that somewhere, it's called "the perfect 
patch")

What I could see is that if you turn that into generic "memory mirror" 
VM code and submit the patches to do that together with some simple
that uses it. I suppose other people could then use it too and it might
end up as a nice generic facility in Linux code.

Then when that generic subsystem is in your hardware specific drivers could 
possibly use it, although it would be definitely strongly prefered if those
were GPL too.

-Andi

