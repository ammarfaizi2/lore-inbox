Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946936AbWKAQgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946936AbWKAQgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946938AbWKAQgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:36:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:51949 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946936AbWKAQgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:36:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KQ8lXQiXhZfFY3mHqiSQOsyFwIY8O6L2qDue6CsUbZjLVNuIsklDcHoTG4qacoz5kMWv0PlADahTurE1ITLP0fHA9SWy1UspwsYC2a9LmhCLTePProyn90QL8KJrMg64tNh1QSWSWbcz7/2xCh7DgJkLoYoHinv+0XnSgka89uU=
Message-ID: <41840b750611010836qe9d49a0q6c5179babd6bc137@mail.gmail.com>
Date: Wed, 1 Nov 2006 18:36:37 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
Subject: Re: [PATCH v2] Re: Battery class driver.
Cc: "David Woodhouse" <dwmw2@infradead.org>,
       "Richard Hughes" <hughsient@gmail.com>,
       "Xavier Bestel" <xavier.bestel@free.fr>,
       "Jean Delvare" <khali@linux-fr.org>, davidz@redhat.com,
       "Dan Williams" <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>,
       "Pavel Machek" <pavel@suse.cz>
In-Reply-To: <20061101143634.GB12619@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
	 <6DP6m926.1162281579.9733640.khali@localhost>
	 <41840b750610310542u2bbcf4b6y5f9f812ebd12445@mail.gmail.com>
	 <1162302686.31012.47.camel@frg-rhel40-em64t-03>
	 <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com>
	 <1162387577.5001.7.camel@hughsie-laptop>
	 <1162389260.18406.62.camel@shinybook.infradead.org>
	 <20061101143634.GB12619@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/06, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Wed, 01 Nov 2006, David Woodhouse wrote:
> > On Wed, 2006-11-01 at 13:26 +0000, Richard Hughes wrote:
> > > With the battery class driver, how would that be conveyed? Would the
> > > sysfs file be deleted in this case, or would the value of the sysfs
> > > key be something like "<invalid>".
> >
> > I'd be inclined to make the read return -EINVAL.
>
> -EIO for transient errors (e.g. access to the embedded controller/battery
> charger/whatever fails at that instant), -EINVAL for "not supported"
> (missing ACPI method, attribute not supported in the specific hardware)?

Shouldn't it be -EIO or -EBUSY for transient errors (depending on
type), and -ENXIO when not provided by hardware?
The -EINVAL is more appropriate for bad user-supplied values (out of
range etc.) to writable attributes.

  Shem
