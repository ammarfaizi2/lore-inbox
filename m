Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWJLPzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWJLPzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWJLPzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:55:31 -0400
Received: from holoclan.de ([62.75.158.126]:55486 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1422728AbWJLPz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:55:28 -0400
Date: Thu, 12 Oct 2006 17:24:24 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-thinkpad@linux-thinkpad.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       acpi-devel@kernel.org, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ltp] Re: X60s w/t kern 2.6.19-rc1-git: two BUG warnings
Message-ID: <20061012152424.GB11325@gimli>
Mail-Followup-To: linux-thinkpad@linux-thinkpad.org,
	Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
	"Brown, Len" <len.brown@intel.com>, acpi-devel@kernel.org,
	Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>
References: <20061010062826.GC9895@gimli> <452BECAE.2070001@goop.org> <m17iz7oj3w.fsf@ebiederm.dsl.xmission.com> <20061011070650.GA7003@gimli> <20061012070132.GA27832@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012070132.GA27832@gimli>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Thu, Oct 12, 2006 at 09:01:32AM +0200, Dipl.-Ing.
	Martin Lorenz wrote: > On Wed, Oct 11, 2006 at 09:06:50AM +0200,
	Dipl.-Ing. Martin Lorenz wrote: > > On Tue, Oct 10, 2006 at 05:18:27PM
	-0600, Eric W. Biederman wrote: > > > Jeremy Fitzhardinge
	<jeremy@goop.org> writes: > > > > > > > Martin Lorenz wrote: > > > >>
	Dear kernel gurus, > > > >> > > > > > > > > (CC:s added to various
	interested parties.) > > > > > > > >> whatever I do and whic problem I
	seem to get fixed new ones arise: > > > >> > > > >> now I loose ACPI
	events after suspend/resume. not every time, but roughly 3 > > > >> out
	of 4 times. > > > >> > > > > > > > > Yes, I'm seeing this as well. It
	used to be a 100% failure, so there has been > > > > some improvement.
	On the other hand, before that it used to work perfectly... > > > >
	Unfortunately I don't have a good feeling for when these changes
	happened. > > > > > > I have to say sorry for insisting on the ACPI
	issue > after digging a little deeper I found that it must come from
	somewhere in > the ibm_acpi code and maybe even in a helper script. I
	still have to seek > for that one and read the ibm_acpi patches and
	discussion that go on for > over a week now in ltp... > > maybe soneone
	can quickly tell me, what it is trying to point out with this > my
	current workaround is to send a reset to /proc/acpi/ibm/hotkey > as last
	command on resume > > > I put up some information on my current
	configuration on > > http://www.lorenz.eu.org/~mlo/kernel/ > > tell me,
	what I should add to help > > > I will add dumps of /proc/acpi/ibm/*
	before and after resume shortly > it's getting stranger and stranger
	[...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 09:01:32AM +0200, Dipl.-Ing. Martin Lorenz wrote:
> On Wed, Oct 11, 2006 at 09:06:50AM +0200, Dipl.-Ing. Martin Lorenz wrote:
> > On Tue, Oct 10, 2006 at 05:18:27PM -0600, Eric W. Biederman wrote:
> > > Jeremy Fitzhardinge <jeremy@goop.org> writes:
> > > 
> > > > Martin Lorenz wrote:
> > > >> Dear kernel gurus,
> > > >>
> > > >
> > > > (CC:s added to various interested parties.)
> > > >
> > > >> whatever I do and whic problem I seem to get fixed new ones arise:
> > > >>
> > > >> now I loose ACPI events after suspend/resume. not every time, but roughly 3
> > > >> out of 4 times.
> > > >>
> > > >
> > > > Yes, I'm seeing this as well.  It used to be a 100% failure, so there has been
> > > > some improvement.  On the other hand, before that it used to work perfectly...
> > > > Unfortunately I don't have a good feeling for when these changes happened.
> > > 
> > 
> I have to say sorry for insisting on the ACPI issue
> after digging a little deeper I found that it must come from somewhere in
> the ibm_acpi code and maybe even in a helper script. I still have to seek
> for that one and read the ibm_acpi patches and discussion that go on for
> over a week now in ltp...
> 
> maybe soneone can quickly tell me, what it is trying to point out with this
> my current workaround is to send a reset to /proc/acpi/ibm/hotkey
> as last command on resume
> 
> > I put up some information on my current configuration on
> > http://www.lorenz.eu.org/~mlo/kernel/
> > tell me, what I should add to help 
> > 
> I will add dumps of /proc/acpi/ibm/* before and after resume shortly
> 
it's getting stranger and stranger

now that I have included my workaround in /etc/acpi/sleepbtn.sh I can find
the following different entries in the acpi logfile:

this is the first suspend using Fn+F4

[Thu Oct 12 16:43:03 2006] received event "ibm/hotkey HKEY 00000080 00001004"
[Thu Oct 12 16:43:03 2006] notifying client 3662[0:0]
[Thu Oct 12 16:43:03 2006] notifying client 3706[107:111]
[Thu Oct 12 16:43:03 2006] notifying client 4879[0:0]
[Thu Oct 12 16:43:03 2006] executing action "/etc/acpi/sleepbtn.sh"
[Thu Oct 12 16:43:03 2006] BEGIN HANDLER MESSAGES
Calling INT 0x15 (F000:5E81)
 EAX is 0x10005F00
Calling INT 0x15 (F000:5E81)
 EAX is 0x10005F40
Calling INT 0x15 (F000:5E81)
 EAX is 0x5F34
Calling INT 0x15 (F000:5E81)
 EAX is 0x5F35
[Thu Oct 12 16:52:05 2006] END HANDLER MESSAGES
[Thu Oct 12 16:52:05 2006] action exited with status 0
[Thu Oct 12 16:52:05 2006] completed event "ibm/hotkey HKEY 00000080 00001004"


but the second time not a ibm/hotkey HKEY 00000080 00001004 event is
reported and handeled but a button/sleep SLPB 00000080 00000001
resulting in this log entry:

[Thu Oct 12 17:06:08 2006] received event "button/sleep SLPB 00000080 00000001"
[Thu Oct 12 17:06:08 2006] notifying client 3662[0:0]
[Thu Oct 12 17:06:08 2006] notifying client 3706[107:111]
[Thu Oct 12 17:06:08 2006] notifying client 4879[0:0]
[Thu Oct 12 17:06:08 2006] executing action "/etc/acpi/sleep.sh"
[Thu Oct 12 17:06:08 2006] BEGIN HANDLER MESSAGES
xscreensaver-command: throttled.

xscreensaver-command: activating and locking.

ifdown: interface eth0 not configured
ifdown: interface tap0 not configured
Stopping MySQL database server: mysqld.
Shutting down ALSA...done.
Starting 915resolution: Intel 800/900 Series VBIOS Hack : version 0.5.2

Chipset: 945GM
BIOS: TYPE 1
Mode Table Offset: $C0000 + $269
Mode Table Entries: 36

Patch mode 54 to resolution 1024x768 complete
915resolution.
Function not supported
FATAL: Module e1000 not found.
Starting 915resolution: Intel 800/900 Series VBIOS Hack : version 0.5.2

Chipset: 945GM
BIOS: TYPE 1
Mode Table Offset: $C0000 + $269
Mode Table Entries: 36

Patch mode 54 to resolution 1024x768 complete
915resolution.
Internet Software Consortium DHCP Client 2.0pl5
Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
All rights reserved.

Please contribute if you find this software useful.
For info, please visit http://www.isc.org/dhcp-contrib.html

eth1: unknown hardware address type 24
irda0: unknown hardware address type 783
Setting up ALSA...done.
grep: /proc/acpi/fan/*/state: No such file or directory
FATAL: Module acpi_sbs not found.
FATAL: Module acpi_sbs not found.
eth1: unknown hardware address type 24
irda0: unknown hardware address type 783
Listening on LPF/eth0/00:16:d3:22:9b:82
Sending on   LPF/eth0/00:16:d3:22:9b:82
Sending on   Socket/fallback/fallback-net
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPREQUEST on eth0 to 255.255.255.255 port 67
xscreensaver-command: no response to command.
[Thu Oct 12 17:11:08 2006] END HANDLER MESSAGES
[Thu Oct 12 17:11:08 2006] action exited with status 0
[Thu Oct 12 17:11:08 2006] completed event "button/sleep SLPB 00000080 00000001"


gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
