Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311839AbSDIWOU>; Tue, 9 Apr 2002 18:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311841AbSDIWOT>; Tue, 9 Apr 2002 18:14:19 -0400
Received: from mnh-1-05.mv.com ([207.22.10.37]:62732 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S311839AbSDIWOT>;
	Tue, 9 Apr 2002 18:14:19 -0400
Message-Id: <200204092316.SAA05188@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: user-mode port 0.56-2.4.18-15 
In-Reply-To: Your message of "Mon, 08 Apr 2002 01:25:37 GMT."
             <20020408012536.A329@toy.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Apr 2002 18:16:33 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@suse.cz said:
> Why don't you just feed your /dev/random from hosts /dev/random? 

That would open up DOS attacks on the host.  A nasty person inside a UML
could drain the host's /dev/random and hang anything on the host that needs
random numbers.

> Wow.. Why such strange value? 

HZ > 50 is needed to make ps and friends shut up.
HZ % 4 == 0 is needed to make some QOS thing compile.

				Jeff
