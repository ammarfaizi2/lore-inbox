Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272874AbTHRQu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272691AbTHRQu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:50:57 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:15890 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S272874AbTHRQuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:50:55 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Date: Mon, 18 Aug 2003 20:49:57 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307152214.38825.arvidjaar@mail.ru> <200308161938.47935.arvidjaar@mail.ru> <20030816165016.GE9735@kroah.com>
In-Reply-To: <20030816165016.GE9735@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308182049.57093.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 August 2003 20:50, Greg KH wrote:
> > > I like this idea, but now that the name logic has changed in the i2c
> > > code, care to re-do this patch?  Just set the name field instead of
> > > creating a new file in sysfs.
> >
> > something like attached patch? I like it as well :)
>
> Why rename local variables?  Your patch would be a lot smaller if you
> just keep the same local name variable, and fix up the name strings.
>

To make it clear for anyone porting other drivers that we are using type_name 
and not client_name or whatever. In 2.4 every driver have both; mixing name, 
type_name and client_name will just add to confusion.

I will redo patch if you insist but I really prefer having things consistent 
if possible.

thank you

-andrey
