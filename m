Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277805AbRJRRFC>; Thu, 18 Oct 2001 13:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277808AbRJRREw>; Thu, 18 Oct 2001 13:04:52 -0400
Received: from vena.lwn.net ([206.168.112.25]:9484 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S277805AbRJRREj>;
	Thu, 18 Oct 2001 13:04:39 -0400
Message-ID: <20011018170512.25468.qmail@eklektix.com>
To: Patrick Mochel <mochelp@infinity.powertie.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5 
From: corbet-lk@lwn.net (Jonathan Corbet)
In-Reply-To: Your message of "Wed, 17 Oct 2001 16:52:29 PDT."
             <Pine.LNX.4.21.0110171617460.15653-100000@marty.infinity.powertie.org> 
Date: Thu, 18 Oct 2001 11:05:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The (New) Linux Kernel Driver Model

It looks like a good start - a lot of things will be cleaner afterward.

A question...

In struct device_driver:

> probe:
> 	Check for device existence and associate driver with it. 

What, exactly, does "associate driver" mean?  Filling in the struct device
field, perhaps?  Calling register_chrdev (or register_whatever)?  Creation
of a ddfs entry?  As a driver writer I can understand that the probe
routine should check for the existence of some device, and perhaps set up
an internal data structure.  What else happens?

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
