Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVBJSqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVBJSqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVBJSqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:46:10 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:44746 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261226AbVBJSqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:46:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=g4A2/jWptLcFurmDKQfKNsBzfb1Tl0QWrQ/Ijn8mbEAo/J3Cyk7hsOa/aR7+4wZ1hLr95wtpwKO5uu1ToXLUt1GO1mem2rwug+kGrIDprbJ4zquLtBz8Q7jvfHRfgEChna2Ix9NwTuUafBrfjGT4DW7YZWG7BUTlEzmkOAaJ5g0=
Message-ID: <d120d5000502101046d87d13f@mail.gmail.com>
Date: Thu, 10 Feb 2005 13:46:02 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH] add driver matching priorities
Cc: Adam Belay <abelay@novell.com>, rml@novell.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050210183338.GA9308@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1106951404.29709.20.camel@localhost.localdomain>
	 <20050210084113.GZ32727@kroah.com>
	 <1108055918.3423.23.camel@localhost.localdomain>
	 <20050210183338.GA9308@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 10:33:38 -0800, Greg KH <greg@kroah.com> wrote:
> On Thu, Feb 10, 2005 at 12:18:37PM -0500, Adam Belay wrote:
> >
> > The second "*match" function in "struct device_driver" gives the driver
> > a chance to evaluate it's ability of controlling the device and solves a
> > few problems with the current implementation.  (ex. it's not possible to
> > detect ISA Modems with only a list of PnP IDs, and some PCI devices
> > support a pool of IDs that is too large to put in an ID table).
> 
> What deficiancy in the current id tables do you see?  What driver has a
> id table that is "too big"?  Is there some way we can change it to make
> it work better?
> 

Stepping a bit farther away - sometimes generinc matching is not
enough to determine if driver suits for a device - actual probing is
needed (consider atkbd and psmouse - they can both attach to the same
port but we can't determine if it is a keyboard or mouse until we
started probing)
-- 
Dmitry
