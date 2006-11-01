Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752452AbWKAVcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbWKAVcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbWKAVcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:32:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:57828 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752452AbWKAVcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:32:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Ztc262rhJV20fgXQVkBMxVmbx5onZK8mDnLKZYuus80VfYBCPcMJDvEUwY/1wkDw+6zWHVKe4pSh1hDv0z1A8+L46M8AgC3HOg6PGqkp/6utaUvD1LVeOvQXGhBX0ievvnnQi8e4laQcqnRlhNfwdXTdltkKMRhFxIwdyXMfVg4=
Subject: Re: [PATCH v2] Re: Battery class driver.
From: Richard Hughes <hughsient@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, Greg KH <greg@kroah.com>,
       David Zeuthen <davidz@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20061101212720.GA2893@elf.ucw.cz>
References: <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
	 <1162048148.2723.61.camel@zelda.fubar.dk>
	 <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
	 <20061031074946.GA7906@kroah.com>
	 <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com>
	 <20061101193134.GB29929@kroah.com>
	 <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com>
	 <20061101212720.GA2893@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:32:40 +0000
Message-Id: <1162416760.5303.1.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 22:27 +0100, Pavel Machek wrote:
> > The drawback is that someone in userspace who doesn't care about
> units
> > but just wants to show a status report or compute the amount of
> > remaining fooergy divided by the amount of a fooergy when fully
> > charged, like your typical battery applet, will need to parse
> > filenames (or try out a fixed and possibly partial list) to find out
> > which attribute files contain the numbers.
> 
> That's okay, we want userspace to use common library, and doing
> 
> echo $[`cat capacity_remaining:*` / `cat capacity_total:*`]
> 
> is not exactly rocket science. If greg does not like units suffixes,
> that's okay, too, I'm sure handy wildcard match will be possible.

I'm guessing adding the new code to HAL will allow most stuff to keep
working without any changes. I think battstat-applet defaults to using
HAL, and I'm sure gnome-power-manager does. :-)

Richard.

