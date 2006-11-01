Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946875AbWKANlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946875AbWKANlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946876AbWKANlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:41:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:14500 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946875AbWKANlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:41:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CMtBKclxbp3wK1di/R0NEBlo6Zruzki/AoL0QCRkzUQ+FgF8Nb2ZIzADg93YBUmVaNbLDH9Z+dxyjGyN+9WU/rbpTXxOUk8Q+y2qeit440mGl39X/J2Ax5wuLHw9yxwsAdyIu7aZoRh+vdGUBvFXoyvEA4dRwVNA6sf0RQk60qo=
Subject: Re: [PATCH v2] Re: Battery class driver.
From: Richard Hughes <hughsient@gmail.com>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>, Jean Delvare <khali@linux-fr.org>,
       davidz@redhat.com, David Woodhouse <dwmw2@infradead.org>,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com>
References: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
	 <6DP6m926.1162281579.9733640.khali@localhost>
	 <41840b750610310542u2bbcf4b6y5f9f812ebd12445@mail.gmail.com>
	 <1162302686.31012.47.camel@frg-rhel40-em64t-03>
	 <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 13:26:17 +0000
Message-Id: <1162387577.5001.7.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 16:06 +0200, Shem Multinymous wrote:
> 
> In the case at hand we have mWh and mAh, which measure different
> physical quantities. You can't convert between them unless you have
> intimate knowledge of the battery's chemistry and condition, which we
> don't.

I'm thinking specifically for ACPI at the moment.

When ACPI can't work out a value, i.e. it's not known, it returns a
value of 0xFFFFFFFF. This can happen either for a split second on
disconnect, or if the hardware really doesn't know the value.

With the battery class driver, how would that be conveyed? Would the
sysfs file be deleted in this case, or would the value of the sysfs key
be something like "<invalid>".

This is something I'm just thinking about for the HAL backend, and
whatever is decided should probably be documented.

Richard.


