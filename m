Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281142AbRKGXzd>; Wed, 7 Nov 2001 18:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281158AbRKGXzX>; Wed, 7 Nov 2001 18:55:23 -0500
Received: from marine.sonic.net ([208.201.224.37]:52000 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S281142AbRKGXzS>;
	Wed, 7 Nov 2001 18:55:18 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 7 Nov 2001 15:55:14 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107155514.C27157@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <3BE99650.70AF640E@zip.com.au>, <3BE99650.70AF640E@zip.com.au> <20011107133301.C20245@mikef-linux.matchmail.com> <3BE9AF15.50524856@zip.com.au>, <3BE9AF15.50524856@zip.com.au> <20011107145229.A560@mikef-linux.matchmail.com> <3BE9BCC8.925A1234@zip.com.au> <3BE9C56D.3D31E185@idcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE9C56D.3D31E185@idcomm.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 04:36:13PM -0700, D. Stimits wrote:
> It might be interesting if modules.conf had a scheme similar to
> versioning for System.map. E.G., search first for
> /etc/modules.conf-2.4.9-6, and if not found, go for /etc/modules.conf
> (as a fallback in case version-specific didn't exist).

It does, more or less, if you use the if directives:

if -f /etc/modules.conf-2.4.9-6
	include /etc/modules.conf-2.4.9-6
else
	[regular stuff here
endif

Or better yet, something like

option foo one=this two=that
if `uname -4` > 2.4.x 
	add option foo three=blah
endif

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
