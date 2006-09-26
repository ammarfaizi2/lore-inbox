Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWIZNlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWIZNlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWIZNlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:41:21 -0400
Received: from mx1.suse.de ([195.135.220.2]:14519 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751482AbWIZNlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:41:21 -0400
Date: Tue, 26 Sep 2006 06:41:19 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH 30/47] Driver core: create devices/virtual/ tree
Message-ID: <20060926134119.GA11435@kroah.com>
References: <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <d120d5000609260624j4fb1f45en6ce2339843fcc1ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000609260624j4fb1f45en6ce2339843fcc1ad@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 09:24:15AM -0400, Dmitry Torokhov wrote:
> On 9/26/06, Greg KH <greg@kroah.com> wrote:
> >From: Greg Kroah-Hartman <gregkh@suse.de>
> >
> >This change creates a devices/virtual/CLASS_NAME tree for struct devices
> >that belong to a class, yet do not have a "real" struct device for a
> >parent.  It automatically creates the directories on the fly as needed.
> >
> 
> Why do you need multiple virtual devices? All parentless class devices
> could grow from a single virtual device.

They could, but it's a mess of a single directory if you do that.
Having /sys/devices/virtual/tty/ as a place for all tty virtual device
is nicer than /sys/devices/virtual/ as a single place for all of them
(mem, network, tty, misc, etc.)

thanks,

greg k-h
