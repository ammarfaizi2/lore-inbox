Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760131AbWLCWDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760131AbWLCWDj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760134AbWLCWDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:03:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:10331 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1760131AbWLCWDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:03:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=AHcIq9P3HtJFfoaxkpeZFC4dqKunnFNJTM0fp4Mlg0GOcozxiT5Rf2I7ez0on4u9EqzirnsMoA9dVZh5COujI7Wm6Ham0CQI0L8MlK332GK8gouoa4d4VYi8s2B6eSnI5Q0gkhfTgmmsDOYpsL/TLNNA1qU4+qJSyHG0wImkH68=
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Date: Sun, 3 Dec 2006 23:03:20 +0100
User-Agent: KMail/1.9.5
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Linville <linville@tuxdriver.com>,
       Jiri Benc <jbenc@suse.cz>, Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>
References: <200612031936.34343.IvDoorn@gmail.com> <1165173482.3233.240.camel@laptopd505.fenrus.org>
In-Reply-To: <1165173482.3233.240.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612032303.21293.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 December 2006 20:18, Arjan van de Ven wrote:
> On Sun, 2006-12-03 at 19:36 +0100, Ivo van Doorn wrote:
> > +
> > +       down(&master->key_sem);
> > + 
> 
> Hi,
> 
> this one seems to be used as a mutex only, please consider using a mutex
> instead, as is the default for new code since 2.6.16 or so....

It was indeed intended to be a mutex, I had however missed
the presence of the mutex header in the kernel.
Will fix this immediately.

Thanks,

Ivo
