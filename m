Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVCOWJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVCOWJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCOWG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:06:57 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:49181 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261920AbVCOWF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:05:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dguazQP18uw1w8k8MDyOIyQvZR174rqfNCc+aKjradyXbbo8qpGlAb3q30TZWUTpwoemdl5Uy1RHyIqgBhAcY00oNI6UDxfxguPDvQM49VbeXiw5ipuyHd1yZuqqUk1Pgj8C7fJHcQ0AizYeDpkoMN/Lua3TWD1u2ZA01uvvqts=
Message-ID: <d120d5000503151405381f183a@mail.gmail.com>
Date: Tue, 15 Mar 2005 17:05:40 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [RFC] Changes to the driver model class code.
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <200503151314.40510.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050315170834.GA25475@kroah.com>
	 <200503151235.02934.david-b@pacbell.net>
	 <d120d50005031512485125db18@mail.gmail.com>
	 <200503151314.40510.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 13:14:40 -0800, David Brownell <david-b@pacbell.net> wrote:
> You still haven't answered my question.  My observation was that
> only the class code can in any sense be called "new" ... so your
> blanket statement seemed to overlook several essential points!
> 
> Which parts of the driver model were you thinking of?
> 
> That pre-driver model stuff went away in maybe 2.6.5 or so, I
> forget just when.

I think I was shopping around for the examples of proper driver model
integration in 2.6.2 - 2.6.3 timeframe for the serio bus. I was
looking at how USB was working around the fact that one can not
add/remove children from the probe/remove methods. I can not tell you
what exactly gave me the impression that conversion is still in
progress, probably the comments like this:

     /* FIXME should device_bind_driver() */
         iface->driver = driver;
         usb_set_intfdata(iface, priv);
         return 0;

Now I see it was changed shortly after I looked there. And I see that
my impression was wrong, it _is_ tightly integrated with the driver
model now.

>  If you think those changes can easily be
> reversed, I suggest you think again ... they enabled a LOT of
> likewise-overdue cleanups.

Note that I am arguing for keeping existing interface, not removing it.

-- 
Dmitry
