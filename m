Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbSIYLke>; Wed, 25 Sep 2002 07:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbSIYLke>; Wed, 25 Sep 2002 07:40:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21773 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261942AbSIYLke>; Wed, 25 Sep 2002 07:40:34 -0400
Date: Wed, 25 Sep 2002 12:45:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Egger <degger@fhm.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] streq()
Message-ID: <20020925124536.A6083@flint.arm.linux.org.uk>
References: <20020924045313.0FBE52C075@lists.samba.org> <1032953252.18004.18.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1032953252.18004.18.camel@sonja.de.interearth.com>; from degger@fhm.edu on Wed, Sep 25, 2002 at 01:27:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 01:27:32PM +0200, Daniel Egger wrote:
> Something along the lines of:
> Start comparying by granules with the biggest type the architecture has
> to offer which will fit into the length of the string and going down
> to the size of 1 char bailing out as soon as the granules don't match.

Small problem - you need to find the length first.  Which means you need
to scan each string, and use the smaller.

So, instead of iterating in some fashion over the strings once, you
iterate over one string calculating its length.  You iterate over the
other string to find its length.  Then you iterate over both strings
comparing them.

Wouldn't it be faster just to iterate over both strings at the same time
only once?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

