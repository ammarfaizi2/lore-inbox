Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVJQVyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVJQVyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVJQVyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:54:53 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:2472 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751135AbVJQVyx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:54:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nX6sbih//Yr660I8qnlI86QaIW9hQ7Ihxb1q2AgO9mC+/8fGwg0DmZ8EdnWar0Lgql82tdnn8AL5Nhh/mTiq+TjBjtVsc7SGlDw8WJfSKFoDUtJG/ieDqGOPM9UrnRyWbZdT9C68qq45j7YmNIMdhX8X3+aNhEG4WHi4yANhJsA=
Message-ID: <d120d5000510171454w6c59580j7c2b6901c6f750e5@mail.gmail.com>
Date: Mon, 17 Oct 2005 16:54:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <gregkh@suse.de>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Cc: Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
In-Reply-To: <20051017214430.GA5193@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051013020844.GA31732@kroah.com>
	 <20051013105826.GA11155@vrfy.org>
	 <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com>
	 <20051014084554.GA19445@vrfy.org>
	 <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com>
	 <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/05, Greg KH <gregkh@suse.de> wrote:
> So, what to do now?  Here's my proposal for the future.
>
> We figure out some way to agree on the input stuff, using class_device
> and get that into 2.6.15.  Personally, I like the stuff I just did and
> is in the -mm tree :)
>

If we are shooting at 2.6.15 I would just go with original 2-class
solution (input and input_dev) with doing symlinks in form of
/sys/class/input/mouseX/device -> /sys/class/input_dev/inputX

Correct me if I am wrong but this is least invasive and (at least for
older hotplug installations) all that is needed to make it work is a
symlink from input.agent to input_dev.agent.

--
Dmitry
