Return-Path: <linux-kernel-owner+w=401wt.eu-S932493AbWLLWbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWLLWbp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWLLWbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:31:44 -0500
Received: from outbound-mail-32.bluehost.com ([69.89.18.152]:35692 "HELO
	outbound-mail-32.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932493AbWLLWbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:31:43 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Date: Tue, 12 Dec 2006 14:31:10 -0800
User-Agent: KMail/1.9.5
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Holger Macht <hmacht@suse.de>, len.brown@intel.com,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Brandon Philips <brandon@ifup.org>, Kay Sievers <kay.sievers@vrfy.org>
References: <20061204224037.713257809@localhost.localdomain> <20061211120508.2f2704ac.kristen.c.accardi@intel.com> <20061212221504.GA4104@datenfreihafen.org>
In-Reply-To: <20061212221504.GA4104@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612121431.11919.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 12, 2006 2:15 pm, Stefan Schmidt wrote:
> Hello.
>
> On Mon, 2006-12-11 at 12:05, Kristen Carlson Accardi wrote:
> > On Sat, 9 Dec 2006 12:59:58 +0100
> >
> > Holger Macht <hmacht@suse.de> wrote:
> > > Well, I like to have them ;-)
> >
> > Ok - how is this?
> >
> > Send a uevent to indicate a device change whenever we dock or
> > undock, so that userspace may now check the dock status via
> > sysfs.
>
> I would like to have two different events for dock and undock.
>
> This way the userspace listener don't need to check the status file
> in sysfs to know if there was a dock or undock after getting the
> event.
>
> Anyway the status file is still usefull for programs don't react on
> the events, but like to know if the laptop is docked before starting
> for example.

FWIW, Kay and Neil recently went back and forth regarding what sorts of 
events to generate for MD online/offline events.  In concept md 
online/offline and dock/undock seem similar enough that the 'change' 
events Kay requested for md probably make sense in the dock/undock 
context as well, but I've Cc'd him just in case.

Jesse
