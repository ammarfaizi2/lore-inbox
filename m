Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422817AbWJYXjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWJYXjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 19:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWJYXjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 19:39:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:42960 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422817AbWJYXjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 19:39:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EtGfkS25mg4kV/5oN06n/c8xPYyU+VaH5ZhVN114CnB6FngYMvlO283CMcAGPP8d8z+9OajOFz8bovPYL2ljJsMwTxZm7Y1Vs8YYeNkTpnhHU5YyfJQ6MKXYdhZalszV8jELCoyEPxM1jX2F39pkfXYpny8EMkQMgT7f7r7cXPQ=
Message-ID: <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
Date: Thu, 26 Oct 2006 01:39:00 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Cc: "Richard Hughes" <hughsient@gmail.com>, "Dan Williams" <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       "David Zeuthen" <davidz@redhat.com>,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <1161815138.27622.139.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/26/06, David Woodhouse <dwmw2@infradead.org> wrote:
> Ok, thanks for the feedback -- I think I've done all that. It wasn't in
> 'diff -u' form so I may have misapplied it. Please confirm.

Looks perfect. And I agree that current_{,now} etc. is better than my
suggestion of current_{avg,now}.

(I used free text instead of diff -u so I can give the rationale;
should have included both, I guess).


> > I take it you don't want to deal with battery control actions for now.
>
> They're simple enough to add. We can do it when the tp driver gets
> converted over.

Sure. But It will require some thought. For example, the interface
will need to encompass the non-symmetric pair of force commands on
ThinkPads:
"discharge the battery until further notice" vs.
"don't charge the battery for N minutes".

Also, ThinkPads express  the start/stop charging thresholds in
percent, whereas I imagine some other hardware will represent it as
capacity.

What other examples do we have of machines with battery control commands?

  Shem
