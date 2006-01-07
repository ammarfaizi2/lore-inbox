Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWAGEg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWAGEg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 23:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWAGEg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 23:36:28 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:16820 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030330AbWAGEg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 23:36:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: request for opinion on synaptics, adb and powerpc
Date: Fri, 6 Jan 2006 23:36:25 -0500
User-Agent: KMail/1.8.3
Cc: Peter Osterlund <petero2@telia.com>, Luca Bigliardi <shammash@artha.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20060106231301.GG4732@kamaji.shammash.lan> <200601062317.03712.dtor_core@ameritech.net> <1136608396.4840.206.camel@localhost.localdomain>
In-Reply-To: <1136608396.4840.206.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601062336.26035.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 23:33, Benjamin Herrenschmidt wrote:
> 
> > Why would you want to switch to relative mode when leaving X? As far as
> > I know the only other mouse "user" out there is GPM and there are patches
> > available for it to use event device:
> > 
> > 	http://geocities.com/dt_or/gpm/gpm.html
> > 
> > Unfortunately the maintainer can't find time to merge these so they were
> > sitting there for over 2 years. FWIW Fedora patches their GPM with these.
> 
> gpm among other legacy things ...
> 

What other legacy things? And in that case I think manually forcing protocol
back to relative would be an option.

The thing is that Synaptics in absolute and relative mode is 2 completely
different devices with different capabilities. If you want to switch mode
you really need to kill old input device and create a brand new one.

-- 
Dmitry
