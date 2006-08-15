Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWHOTwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWHOTwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWHOTwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:52:32 -0400
Received: from vena.lwn.net ([206.168.112.25]:40335 "HELO lwn.net")
	by vger.kernel.org with SMTP id S932130AbWHOTwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:52:31 -0400
Message-ID: <20060815195231.17015.qmail@lwn.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop second arg of unregister_chrdev() 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 15 Aug 2006 07:35:22 +0400."
             <20060815033522.GA5163@martell.zuzino.mipt.ru> 
Date: Tue, 15 Aug 2006 13:52:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * "name" is trivially unused.
> * Requirement to pass to unregister function anything but cookie you've
>   got from register counterpart is wrong.

Might this, instead, be an opportunity to get rid of the internal
register_chrdev() and unregister_chrdev() calls in favor of the cdev
interface?  register_chrdev() is a bit of a backward-compatibility hack
at this point, and cdevs, in theory, are safer since they won't present
drivers with minor numbers they might not be prepared to handle.

jon

