Return-Path: <linux-kernel-owner+w=401wt.eu-S933059AbWLITow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbWLITow (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935199AbWLITow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:44:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:50904 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933059AbWLITov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:44:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cnnOdpMXd3oHr3b2GSmAEb48h37ePNv4/avq/J4NvRlrcDVRzmnpB/WmUjm+Y9SmVvPtlDCeI1G+HUHMR2Pbfvm5OHfOASuIEhBI901ddEK7M156HBdfxXNBiIyEF2lCxWNbnm6PG9QRWGAWNyAkIm9Dmo6ZyWpxlTeI6ODqW6A=
Message-ID: <59ad55d30612091144s8356d7dw7c68530238ac79e7@mail.gmail.com>
Date: Sat, 9 Dec 2006 14:44:49 -0500
From: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@bitplanet.net>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
Cc: linux1394-devel@lists.sourceforge.net,
       "Kristian H?gsberg" <krh@redhat.com>,
       "Erik Mouw" <erik@harddisk-recovery.com>,
       "Marcel Holtmann" <marcel@holtmann.org>, "Pavel Machek" <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <45798022.2090104@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	 <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com>
	 <20061205160530.GB6043@harddisk-recovery.com>
	 <20060712145650.GA4403@ucw.cz> <45798022.2090104@s5r6.in-berlin.de>
X-Google-Sender-Auth: bdf893a8aa64a596
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Pavel Machek wrote at linux-kernel:
> > On Tue 05-12-06 17:05:30, Erik Mouw wrote:
> >> On Tue, Dec 05, 2006 at 10:13:55AM -0500, Kristian H?gsberg wrote:
> >> > Marcel Holtmann wrote:
> >> > >can you please use drivers/firewire/ if you want to start clean or
> >> > >aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
> >> > >the directory path is not really helpful.
> >> >
> >> > Yes, that's probably a better idea.  Do you see a problem with using fw_*
> >> > as a prefix in the code though?  I don't see anybody using that prefix, but
> >> > Stefan pointed out to me that it's often used to abbreviate firmware too.
> >>
> >> So what about fiwi_*? If that's too close to wifi_*, try frwr_.
> >
> > Ugly, but fwire could be acceptable.
>
> How about this:
> Let's let Kristian continue to work with his chosen fw_ prefix until his
> drivers are ready to be pulled in (into the linux1394 repo and -mm),
> then make a decision about prefixes. It's mostly a matter of running sed
> over the files.

Yeah, I'm not changing it just yet, but I'm not too attached to fw_
and I think that ieee1394_ will work better.  The modutil tools
already use ieee1394 for device_id tables.

> Regarding the directory name, I favor to stick everything into
> drivers/ieee1394 even if it could get crowded during a transition period.

Yeah, if we're going with the ieee1394 prefix, it'd make the most
sense if the files live in drivers/ieee1394.

Kristian
