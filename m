Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312308AbSDJAmY>; Tue, 9 Apr 2002 20:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312314AbSDJAmX>; Tue, 9 Apr 2002 20:42:23 -0400
Received: from mnh-1-15.mv.com ([207.22.10.47]:44558 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S312308AbSDJAmU>;
	Tue, 9 Apr 2002 20:42:20 -0400
Message-Id: <200204100144.UAA05950@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: user-mode port 0.56-2.4.18-15 
In-Reply-To: Your message of "Wed, 10 Apr 2002 00:17:16 +0200."
             <20020409221716.GI5148@atrey.karlin.mff.cuni.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Apr 2002 20:44:24 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@suse.cz said:
> Okay, make it /dev/urandom ;-). 

Doesn't /dev/urandom have exactly the same DOS properties as /dev/random?
I.e. it reads real random numbers until the entropy pool is empty, then 
starts returning pseudo-random numbers?  If so, things on the host will 
still hang when they then try to read /dev/random.

Also, UML processes deserve crytographically secure numbers just as much as 
host proceses do.  When something opens /dev/random, /dev/random is exactly
what it should get.

				Jeff

