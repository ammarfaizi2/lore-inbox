Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbRFBVmx>; Sat, 2 Jun 2001 17:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbRFBVmd>; Sat, 2 Jun 2001 17:42:33 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50091 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261639AbRFBVmb>;
	Sat, 2 Jun 2001 17:42:31 -0400
Message-ID: <3B195DC3.EE919B3F@mandrakesoft.com>
Date: Sat, 02 Jun 2001 17:42:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Reading from /dev/fb0 very slow?
In-Reply-To: <20010602105249.A979@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> I did some benchmarks, and my framebuffer is *way* faster when writing
> than when reading:
> 
> root@bug:/home/pavel# time cat /tmp/test > /dev/fb0
> 0.01user 0.08system 0.09 (0m0.097s) elapsed 93.13%CPU
> root@bug:/home/pavel# time cat /dev/fb0 > /dev/null
> 0.00user 0.62system 0.62 (0m0.620s) elapsed 99.93%CPU
> root@bug:/home/pavel#
> 
> That is 6 times slower! This is also very visible in X, where moving
> regions is expensive, while just drawing regions is fast. For example
> gnome-terminal is *way* faster *with* transparent background option.
> 
> Any idea why such assymetry? [This is toshiba 4030cdt with vesafb and
> 2.4.5]

Do you have write combining enabled?

-- 
Jeff Garzik      | Echelon words of the day, from The Register:
Building 1024    | FRU Lebed HALO Spetznaz Al Amn al-Askari Glock 26 
MandrakeSoft     | Steak Knife Kill the President anarchy echelon
                 | nuclear assassinate Roswell Waco World Trade Center
