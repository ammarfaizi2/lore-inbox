Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWJ1TyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWJ1TyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWJ1TyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:54:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9647 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751370AbWJ1TyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:54:10 -0400
Subject: Re: [PATCH v2] Re: Battery class driver.
From: David Zeuthen <davidz@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Shem Multinymous <multinymous@gmail.com>,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <20061028185513.GD5152@ucw.cz>
References: <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
	 <1162048148.2723.61.camel@zelda.fubar.dk>  <20061028185513.GD5152@ucw.cz>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 15:53:56 -0400
Message-Id: <1162065236.2723.83.camel@zelda.fubar.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 18:55 +0000, Pavel Machek wrote:
> Bad idea... I bet someone will just ignore the units part, because all
> the machines he seen had mW there. 

Sure, user space can do silly things. Just ask davej. Let's try to
assume they don't.

> Just put it into the name:
> 
> power_avg_mV

Bad idea... it means user space will have to try to open different files
and what happens when someone introduces a new unit? Ideally I'd like
the unit to be part of the payload of the sysfs file. Second to that I
think having the unit in a separate file is preferable.

     David


