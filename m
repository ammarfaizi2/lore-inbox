Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318919AbSHEWfT>; Mon, 5 Aug 2002 18:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318920AbSHEWfT>; Mon, 5 Aug 2002 18:35:19 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:46351 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318919AbSHEWfT>;
	Mon, 5 Aug 2002 18:35:19 -0400
Date: Mon, 5 Aug 2002 15:36:20 -0700
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] usb_string fix
Message-ID: <20020805223620.GC29396@kroah.com>
References: <UTC200208052142.g75Lg9C25845.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200208052142.g75Lg9C25845.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 08 Jul 2002 21:20:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 11:42:09PM +0200, Andries.Brouwer@cwi.nl wrote:
> 
> [I thought I sent this yesterday night, but don't see it on l-k,
> maybe I forgot. Sorry if I send it twice.]
> 
> Things are indeed as conjectured, and I can reproduce the situation
> where usb_string() returns -EPIPE. Now that this is an internal
> error code for the USB subsystem, and not meant to get out to the
> user, I made these driverfs files empty in case of error.
> (While if there is no error but the string has length 0,
> the file will consist of a single '\n'.)
> 
> One fewer random memory corruption. Unfortunately, there are more.

Thanks for the fix, I've applied it to my trees.

greg k-h
