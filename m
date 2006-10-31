Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423336AbWJaOGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423336AbWJaOGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423338AbWJaOGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:06:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:44664 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423336AbWJaOGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:06:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aHBC61C7L+PjKBUsDQsBueezej5prRXJF3PkGdwBGZzJZbyUvGCzbYKoJ66uPT9aGVQcUZw5EEdw2GaiaMC816EPA9aCqufpkTz+u2zyZnPCXNJqemddiHqSfIjU1S6uC0ywxocSzZEWufXMXByUHMqcnp2qd9iQsiWyop3z6c8=
Message-ID: <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com>
Date: Tue, 31 Oct 2006 16:06:34 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Xavier Bestel" <xavier.bestel@free.fr>
Subject: Re: [PATCH v2] Re: Battery class driver.
Cc: "Jean Delvare" <khali@linux-fr.org>, davidz@redhat.com,
       "Richard Hughes" <hughsient@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Dan Williams" <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>,
       "Pavel Machek" <pavel@suse.cz>
In-Reply-To: <1162302686.31012.47.camel@frg-rhel40-em64t-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
	 <6DP6m926.1162281579.9733640.khali@localhost>
	 <41840b750610310542u2bbcf4b6y5f9f812ebd12445@mail.gmail.com>
	 <1162302686.31012.47.camel@frg-rhel40-em64t-03>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Xavier Bestel <xavier.bestel@free.fr> wrote:
> > Well, we have to do *something* about those devices that don't have
> > fixed units (see my mail to Greg from a few minutes ago), so which
> > alternative do you prefer?
>
> How about converting on the fly ?

In the case at hand we have mWh and mAh, which measure different
physical quantities. You can't convert between them unless you have
intimate knowledge of the battery's chemistry and condition, which we
don't.

And it would be nice to also allow for power supply devices that use
other, incompatible units like "percent" or "minutes" or "hand crank
revolutions".

  Shem
