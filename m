Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUBKBV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbUBKBV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:21:26 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:42381 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S262153AbUBKBUW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:20:22 -0500
Date: Tue, 10 Feb 2004 17:20:48 -0800
From: Mike Bell <kernel@mikebell.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040211012047.GA4915@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293508.1040803@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40293508.1040803@nortelnetworks.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 02:46:16PM -0500, Chris Friesen wrote:
> I believe this is a misconception.
> 
> Udev uses standard rules by default.  If the end-user (or their distro) 
> wants to add additional rules or override these rules, they can do that.

Right, but why is "override" better than "in addition to" in this case?
With the in addition case, any linux system at least has the
predictable, kernel-generated name, and any app can rely on that name
being the same on. If the user doesn't like it, he/she is free to make
another one, but the old one's still there.

udev's additional flexibility over devfs with regard to naming seems to
boil down to that, udev is instead of, devfs is in addition to. Why is
instead of better? 

There's space savings, but a simpler devfs might actually be more RAM
efficient than using the generic tmpfs with device nodes on it. And
there's the cleanliness of not having unused device nodes around, but
those unused device nodes guarantee that no matter what crazy naming
scheme you personally like for your devices, they're still findable the
old fashioned way too.
