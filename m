Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWH2M3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWH2M3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWH2M3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:29:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:46669 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751440AbWH2M3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:29:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QjnjZqmvGzYWcaUrYQXou07mZqgJ78dT0+1rkLdFN/7BIOCT9Wp4mvuBmnJvGIQhE8tk69GlXqjbVgGtdBTB+YelqIpvyHTIhGUYgQfq9XvTlrQmTGOKGhN+MfbU3x7j/5BhGof9emurdSMIYnd/+fdB/5mwpL9hFQbF7ZR+ooI=
Message-ID: <d120d5000608290529j904b10bh58696820b159fcd4@mail.gmail.com>
Date: Tue, 29 Aug 2006 08:29:13 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: [RPC] OLPC tablet input driver.
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Marcelo Tosatti" <mtosatti@redhat.com>
In-Reply-To: <20060829084443.GA4187@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060829073339.GA4181@aehallh.com>
	 <1156839019.2722.39.camel@laptopd505.fenrus.org>
	 <20060829084443.GA4187@aehallh.com>
X-Google-Sender-Auth: 634ad519bbb12c29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> >
> > also.. there's no locking visible anywhere in the driver... is this
> > right?
>
> It looks like psmouse handles it with a mutex lock around freeing stuff
> and calling the callback function pointers we set on init, so we
> _should_ be safe unless I've missed something.
>
> Add to it that none of the other psmouse drivers are doing locking on
> their own, and I'm fairly sure that this is correct. (But if someone
> knows better, please correct me.)
>

Serio and psmouse cores should handle all necessary locking, no worries here.

-- 
Dmitry
