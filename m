Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVCZEoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVCZEoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 23:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVCZEoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 23:44:10 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:1014 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261979AbVCZEoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 23:44:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mzlhQmk7kTGXNKu9psDamJ+5sEeI3FCLodmJNKRssTLZVraLzpaasTl5l8XUrp8HqI1mtkXd8UvPEaI9DBemALKJU2xAZZphsA3vsAMwP48QFiaJQ+uCffpd2j4JUkEh/gz3HKCjnkkyo30leBCN4KYQnckIS9WhNE6XkYylaV0=
Message-ID: <a44ae5cd05032520446b660d55@mail.gmail.com>
Date: Fri, 25 Mar 2005 23:44:06 -0500
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <20050325205035.23362e79.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050324044114.5aa5b166.akpm@osdl.org>
	 <a44ae5cd05032420122cd610bd@mail.gmail.com>
	 <20050324202215.663bd8a9.akpm@osdl.org>
	 <20050325073846.A18596@flint.arm.linux.org.uk>
	 <20050324234544.135a1eb2.akpm@osdl.org>
	 <20050325104032.786c4257.akpm@osdl.org>
	 <20050325205035.23362e79.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 20:50:35 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> > > root@Monkey100:/sys/class/i2c-adapter/i2c-1# ls
> > > ./  ../  device@
> > > root@Monkey100:/sys/class/i2c-adapter/i2c-1# ls -l
> > > Segmentation fault
> >
> > What device is that, and which driver is handling it?
> 
> If I am allowed a wild guess here... Isn't by any chance i2c-1 one the
> the 3 i2c adapters exported by the nvidiafb driver, which we know isn't
> playing nicely with the i2c core? To me, it is simply a different
> expression of the same bug Miles hit some days ago when loading the
> i2c-dev or eeprom modules [1].

You are exactly right.  The /sys issues had to do with i2c stuff
associated the nvidiafb driver.

          Miles
