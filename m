Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270944AbTGPQIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270945AbTGPQIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:08:20 -0400
Received: from mail.kroah.org ([65.200.24.183]:17843 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270944AbTGPQIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:08:17 -0400
Date: Wed, 16 Jul 2003 09:23:15 -0700
From: Greg KH <greg@kroah.com>
To: Mark McClelland <mark@alpha.dyndns.org>
Cc: Gerd Knorr <kraxel@bytesex.org>,
       Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030716162315.GA7500@kroah.com>
References: <20030715143119.GB14133@bytesex.org> <20030715212714.GB5458@kroah.com> <3F15540E.2040405@alpha.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F15540E.2040405@alpha.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 06:33:02AM -0700, Mark McClelland wrote:
> 
> Is there a convention for naming driver-specific files in /sys? E.g.: 
> ov511_foo, _foo, etc...? I don't want to pollute the namespace.

You get your own subdirectory to play in, so there really isn't much you
can do to hurt the namespace :)

That being said, stay away from files named "device", "driver", and
"dev".  They are used by the driver core (well, "dev" isn't, but each
class provides it...).

Just remember, one value per file and everyone will be happy.

thanks,

greg k-h
