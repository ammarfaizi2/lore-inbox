Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUAABHX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 20:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUAABHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 20:07:23 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:18436 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265311AbUAABHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 20:07:21 -0500
Date: Thu, 1 Jan 2004 02:18:55 +0100
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040101011855.GA13628@hh.idb.hist.no>
References: <20031231002942.GB2875@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231002942.GB2875@kroah.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 04:29:42PM -0800, Greg KH wrote:
> 
>  2) We are (well, were) running out of major and minor numbers for
>     devices.

devfs tried to fix this one by _getting rid_ of those numbers.
Seriously - what are they needed for?  
(Yes, I know why they're needed with /dev on ext2)
Opening a device in devfs went straight to the device from the
inode - no extra lookup of "device numbers"
Numbers were provided mostly for backward compatibility - they
weren't used for the main task of accessing devices.

udev has many other advantages of course, too bad we still
have to carry those numbers around.

Helge Hafting
