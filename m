Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbTC0MZv>; Thu, 27 Mar 2003 07:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbTC0MZv>; Thu, 27 Mar 2003 07:25:51 -0500
Received: from [196.41.29.142] ([196.41.29.142]:64507 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S262510AbTC0MZt>; Thu, 27 Mar 2003 07:25:49 -0500
Subject: Re: lm sensors sysfs file structure
From: Martin Schlemmer <azarah@gentoo.org>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Greg KH <greg@kroah.com>, Mark Studebaker <mds@paradyne.com>,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
In-Reply-To: <3E82EE25.3070308@portrix.net>
References: <1048582394.4774.7.camel@workshop.saharact.lan>
	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
	 <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com>
	 <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com>
	 <3E82D678.9000807@portrix.net>
	 <1048762244.4773.1258.camel@workshop.saharact.lan>
	 <3E82EE25.3070308@portrix.net>
Content-Type: text/plain
Organization: 
Message-Id: <1048768432.4774.1263.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 27 Mar 2003 14:33:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 14:27, Jan Dittmer wrote:

> Btw., why is temperature conversion done twice? First time in kernel 
> space and then with the help of sensors.conf again in user space?
> Wouldn't it be much nicer to move this to the drivers? So there would be 
> no need anymore to do this in userspace and one could rely on the values
> found in sysfs?!
> 

I guess for stuff like fan_div, etc at least, is that not all the
chips are on spec, the sensors are located on different places,
and the why the manufacturer of the board did things could all
influence things.  Thus you need to be able to tweak fan_dev,
etc for each board individually to get the most precise reading.

For instance, what my bios say, and what the raw reading from 
/proc is, is two different things.  I also had to slightly adjust
things between some models of Asus boards I had.


Regards, 

-- 
Martin Schlemmer


