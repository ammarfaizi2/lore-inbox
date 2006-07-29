Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422747AbWG2Lfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747AbWG2Lfb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 07:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWG2Lfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 07:35:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:8945 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932648AbWG2Lfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 07:35:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gh1tINrjjCgSzQTmZw9QVBuwaZBdJhGiDfe8r2I9tsSpUdvJ3bQVTsKhvqKq0eto7nLEj2Ykucgk4kDkGq7wvHW7yyS02QN77iKr8RcIavW7L7tYw7DCM7H0SyvklzZv7j3tW3077L5eoX1zb6+P/SHZv716kse/5IA9E1DdyeI=
Message-ID: <41840b750607290435x379fe818t2df5c2d4ffd4125e@mail.gmail.com>
Date: Sat, 29 Jul 2006 14:35:16 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Mark Underwood" <basicmark@yahoo.com>
Subject: Re: Generic battery interface
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       "Vojtech Pavlik" <vojtech@suse.cz>, "Pavel Machek" <pavel@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060729103707.26737.qmail@web36908.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
	 <20060729103707.26737.qmail@web36908.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/06, Mark Underwood <basicmark@yahoo.com> wrote:
> > The lazy polling approach I described in my last post to Vojtech
> > ("block until there's  a new readout or N milliseconds have passed,
> > whichever is later") looks like a more general, accurate and efficient
> > interface.
>
> This sounds like a good idea. You could do a similar thing using sysfs by
> providing a entry in sysfs which tells userland when the next update is going
> to happen, the userland app can then decide to use this as it's next poll time
> or not.

The driver may not know when the next update will happen, e.g., if its
data source is event-based. Moreover, the driver may be able to
*decide* when the next update will happen (i.e., when to query
poll-based hardware) if the clients say what they need in advance. The
"lazy poll" / "reverse select" handles both of these.

  Shem
