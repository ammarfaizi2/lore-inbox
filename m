Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWDSOK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWDSOK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWDSOK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:10:58 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:11196 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750783AbWDSOK5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:10:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RQkfmamZ9X0me7xsX81kG9YbsJLrGJXQiR4yHWlnhL8mgrVW9MFX26kgX0zYLnNv81C5GiJqqxh0d9FPf5DlToBSACS2Hevw6gTEHNepCIMVyfJ0PqOr8XzyhQrAJwpLPYlxDdTkF5PGuCzAHyIMeuj2EF0ftLObba+2LpX/Ilg=
Message-ID: <35fb2e590604190710l1ca951d6k892b46e0f9778f6@mail.gmail.com>
Date: Wed, 19 Apr 2006 15:10:56 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [RFC] binary firmware and modules
Cc: "Mark Lord" <lkml@rtr.ca>, "Duncan Sands" <duncan.sands@math.u-psud.fr>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1145453842.3564.16.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145088656.23134.54.camel@localhost.localdomain>
	 <200604181537.47183.duncan.sands@math.u-psud.fr>
	 <1145370171.10255.58.camel@localhost>
	 <200604181659.04657.duncan.sands@math.u-psud.fr>
	 <1145374878.10255.69.camel@localhost> <44463B11.6030005@rtr.ca>
	 <1145453842.3564.16.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mark,

mlord>> How does one handle the case of updated firmware from the manufacturer,
mlord>> which requires *no* driver changes?  If the driver has all of
the previously
mlord>> known names/versions hardcoded, then would it refuse to use
the new stuff?

I guess Mark is saying "what if the filename changes". The thing is,
as part of some other work I'm doing right now, I've talked to a few
folks about naming conventions for firmware, etc. In an ideal world,
we'd have some LANNA process for firmware naming that was flexible and
yet allowed us to handle this all cleanly, and we'd perhaps be able to
request_firmware with a minimum version number or whatever. Right now,
the kernel only supports pulling in a binary blob - determining
whether it's the right one is somewhat vague.

> if no driver change is needed, then you simply can replace the firmware
> file and reload the driver. With the BlueFRITZ! USB driver we did this a
> bunch of times and it worked out perfectly. The firmware name in this
> case is only a placeholder.

That's really going to have to continue for the moment I think, until
we can get better infrastructure for handling firmware updates in
userspace and managing versions. The point of my original patch is
that it gives us a starting point to be able to think about this more.

Jon.
