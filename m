Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVCRPOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVCRPOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVCRPOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:14:44 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60645 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261628AbVCRPOj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:14:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Alan Kilian <kilian@bobodyne.com>
Subject: Re: Where is a reference for ioctl32() usage?
Date: Fri, 18 Mar 2005 16:12:46 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <1111103837.11071.83.camel@desk> <1111157632.11071.92.camel@desk>
In-Reply-To: <1111157632.11071.92.camel@desk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200503181612.47286.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 18 März 2005 15:53, Alan Kilian wrote:
>     I am trying to get my PCI bus device driver running on an Xeon 
>     64-bit FC-3 distribution for the first time. It works fine on a
>     32-bit FC-3 distribution.

You should add a compat_ioctl file operation, see
http://lwn.net/Articles/119652/. If your ioctl handler is
64/32 bit clean, you can have a single function for both
unlocked_ioctl and compat_ioctl.

 Arnd <><
