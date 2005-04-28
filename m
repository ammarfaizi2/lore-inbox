Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVD1Fvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVD1Fvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVD1FtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:49:17 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:19331 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262145AbVD1Frs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:47:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [03/07] I2C: Fix incorrect sysfs file permissions in it87 and via686a drivers
Date: Thu, 28 Apr 2005 00:47:42 -0500
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>, khali@linux-fr.org, sensors@stimpy.netroedge.com,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
References: <20050427171446.GA3195@kroah.com> <20050427171617.GD3195@kroah.com>
In-Reply-To: <20050427171617.GD3195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504280047.43130.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 April 2005 12:16, Greg KH wrote:
> As a side note, wouldn't it make sense to check, when creating sysfs
> files, that readable files have a non-NULL show method, and writable
> files have a non-NULL store method? I know drivers are not supposed to
> do stupid things, but there is already a BUG_ON for several conditions
> in sysfs_create_file, so maybe we could add two more?

Checking at creation time is not enough. Even with such check one could
change permissions on a sysfs file and set write bit.

-- 
Dmitry
