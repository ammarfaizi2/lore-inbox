Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWHGQlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWHGQlO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWHGQlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:41:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:43406 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932213AbWHGQlN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:41:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eXJTcw3dvWquaNnh3OPpVRxZk0FlrsGgi/kfL1xfWMm02AVK0+q0H8InjN1S/n8S2Eex62oRl0xeCPoRP62R5hs7c/gMu980MbW2CStBP8gVyeQBymqGxhd2qwQKXnFIDK+NwBCq4Jm3YEohhcuLsb/0gwrXSRcEb02KhuvAsDE=
Message-ID: <41840b750608070941i521fe56crebc491589a67cb59@mail.gmail.com>
Date: Mon, 7 Aug 2006 19:41:11 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Cc: "Pavel Machek" <pavel@suse.cz>, "Robert Love" <rlove@rlove.org>,
       "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060807162743.GA26224@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492242899-git-send-email-multinymous@gmail.com>
	 <20060807134440.GD4032@ucw.cz>
	 <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com>
	 <20060807162743.GA26224@atjola.homenet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Björn Steinbrink <B.Steinbrink@gmx.de> wrote:
> On 2006.08.07 18:13:06 +0300, Shem Multinymous wrote:
> > >> +     struct dmi_device *dev = NULL;
> > >unneeded initializer.
> > On a local variable?!
>
> You assign a new value to it on the next line, without ever using its
> initial value.

The initial value is used in the last parameter to dmi_find_device():

	struct dmi_device *dev = NULL;
	while ((dev = dmi_find_device(type, NULL, dev))) {
		if (strstr(dev->name, substr))
			return 1;
	}


  Shem
