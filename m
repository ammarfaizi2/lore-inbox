Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266416AbRGHC6I>; Sat, 7 Jul 2001 22:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbRGHC56>; Sat, 7 Jul 2001 22:57:58 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:19205 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266416AbRGHC5w>;
	Sat, 7 Jul 2001 22:57:52 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems 
In-Reply-To: Your message of "Sun, 08 Jul 2001 00:14:24 +0200."
             <20010708001424.B10370@pcep-jamie.cern.ch> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jul 2001 12:57:46 +1000
Message-ID: <21945.994561066@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001 00:14:24 +0200, 
Jamie Lokier <lk@tantalophile.demon.co.uk> wrote:
>On this theme, it's just occured to me that the module loader could be
>taught to map ramfs pages directly to module code/data space.  That
>would save a little memory.

I doubt it.  insmod relocates the code and data sections, discards
sections, inserts a struct module, hooks the module into the existing
change and generally mangles the object before it can be used by the
kernel.  Any change to a page prevents it being mapped against cramfs.
If you had a complete page that was identical before and after insmod
had done its work I would be astonished.

